import hashlib
import json
import os
import secrets
import shutil
import subprocess
import sys
import tempfile
import time
import urllib.parse
import urllib.request
from pathlib import Path

READY = Path(os.environ["MUSIC_IMPORT_READY"])
FAILED = Path(os.environ["MUSIC_IMPORT_FAILED"])


def ffmpeg_resample(flac: Path) -> None:
    ffprobe = subprocess.run(
        [
            "ffprobe",
            "-v",
            "error",
            "-select_streams",
            "a:0",
            "-show_entries",
            "stream=sample_rate,bits_per_raw_sample",
            "-of",
            "json",
            flac,
        ],
        check=True,
        capture_output=True,
        text=True,
    )
    try:
        stream = json.loads(ffprobe.stdout)["streams"][0]
    except (KeyError, IndexError, json.JSONDecodeError) as e:
        raise RuntimeError(f"ffprobe output parse: {e!r}")
    rate = int(stream["sample_rate"])
    bits = int(stream["bits_per_raw_sample"])
    if rate <= 48000 and bits <= 24:
        return

    target_rate = 44100 if rate % 44100 == 0 else 48000  # 88.2/176.4kHz -> 44.1kHz
    target_bits = 16 if bits <= 16 else 24

    print(
        f"Resampling '{flac}': {rate}Hz {bits}bit -> {target_rate}Hz {target_bits}bit"
    )
    tmp = flac.with_suffix(".tmp.flac")
    cmd = [
        "ffmpeg",
        "-nostdin",
        "-v",
        "error",
        "-y",
        "-i",
        flac,
        "-map",
        "0:a",
        "-map_metadata",
        "0",
    ]
    if rate != target_rate:
        cmd += ["-af", f"aresample={target_rate}:resampler=soxr:precision=28"]
    if target_bits == 16:
        cmd += ["-c:a", "flac", "-sample_fmt", "s16"]
    else:
        cmd += ["-c:a", "flac", "-sample_fmt", "s32", "-bits_per_raw_sample", "24"]
    subprocess.run([*cmd, tmp], check=True)
    tmp.replace(flac)


def beet_import(dir: Path) -> bool:
    with tempfile.NamedTemporaryFile("r") as log:
        result = subprocess.run(
            ["beet", "import", "-q", "-w", "--from-scratch", "-l", log.name, dir],
            check=False,
        )
        skipped = [
            line.rstrip()
            for line in log
            if line.split(" ", 1)[0] in ("skip", "duplicate-skip")
        ]
    for line in skipped:
        print(f"beets: {line}", file=sys.stderr)
    return result.returncode == 0 and not skipped


def navidrome_subsonic_request(endpoint: str, params: dict) -> dict:
    """Make a request to Navidrome Subsonic API.

    See: https://www.navidrome.org/docs/developers/subsonic-api/
         https://opensubsonic.github.io/docs/endpoints/
    """
    u = f"{os.environ['NAVIDROME_URL']}/rest/{endpoint}"
    salt = secrets.token_urlsafe(32)
    params.update(
        {
            "u": os.environ["NAVIDROME_USER"],
            "t": hashlib.md5(
                (os.environ["NAVIDROME_PASSWORD"] + salt).encode()
            ).hexdigest(),
            "s": salt,
            "v": "1.16.1",
            "c": "music-import",
            "f": "json",
        }
    )
    u = f"{u}?{urllib.parse.urlencode(params)}"

    with urllib.request.urlopen(u, timeout=10) as resp:
        body = json.load(resp)["subsonic-response"]
    if body["status"] != "ok":
        raise RuntimeError(f"navidrome_subsonic_request {endpoint} failed: {body}")
    return body


def main() -> None:
    imported = False
    failed = False
    for entry in sorted(READY.iterdir()):
        ok = False
        if entry.is_dir():
            print(f"Importing {entry.name}")
            try:
                for flac in sorted(entry.rglob("*")):
                    if flac.suffix.lower() == ".flac":
                        ffmpeg_resample(flac)
                ok = beet_import(entry)
            except (subprocess.CalledProcessError, KeyError, ValueError) as e:
                print(f"{entry.name}: {e!r}", file=sys.stderr)

        if ok:
            shutil.rmtree(entry)
            imported = True
            continue

        dest = FAILED / entry.name
        if dest.exists():
            dest = FAILED / f"{entry.name}.{int(time.time())}"
        shutil.move(entry, dest)
        print(f"{entry.name}: moved to {dest}", file=sys.stderr)
        failed = True

    if imported:
        navidrome_subsonic_request("startScan", {"fullScan": "false"})
    if failed:
        sys.exit(1)


if __name__ == "__main__":
    main()
