{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.sops) secrets;
  ready = "/storage/data01/slskd/ready";
  failed = "/storage/data01/slskd/failed";
  navidrome = config.services.navidrome.settings;

  slskdCompleteHook = pkgs.writers.writePython3 "slskd-complete-hook" {flakeIgnore = ["E501"];} ''
    import json
    import os
    import shutil
    from pathlib import Path

    downloads = Path("${config.services.slskd.settings.directories.downloads}").resolve()
    target = Path(json.loads(os.environ["SLSKD_SCRIPT_DATA"])["localDirectoryName"]).resolve()
    if target.parent != downloads or not target.is_dir():
        raise SystemExit(f"{target} isn't a directory or not under {downloads}")
    shutil.move(target, Path("${ready}") / target.name)
  '';
in {
  sops.secrets."music-import".owner = "zach";
  users.users.zach.extraGroups = ["slskd"];

  services.slskd.settings.integrations.scripts.music-import = {
    on = ["DownloadDirectoryComplete"];
    run.executable = slskdCompleteHook;
  };

  systemd = {
    services.slskd.serviceConfig = {
      ReadWritePaths = [ready];
      UMask = "0002";
    };

    tmpfiles.rules = [
      "d ${ready}  0775 slskd slskd -"
      "d ${failed} 0755 zach  zach  -"
    ];

    paths.music-import = {
      wantedBy = ["paths.target"];
      pathConfig.DirectoryNotEmpty = ready;
    };

    services.music-import = {
      after = [
        "navidrome.service"
        "network-online.target"
        "storage-sb01-music.mount"
      ];
      wants = ["network-online.target"];
      path = [
        config.home-manager.users.zach.programs.beets.package
        pkgs.ffmpeg-headless
      ];
      environment = {
        MUSIC_IMPORT_FAILED = failed;
        MUSIC_IMPORT_READY = ready;
        NAVIDROME_URL = "http://${navidrome.Address}:${toString navidrome.Port}";
        PYTHONUNBUFFERED = "1";
      };
      serviceConfig = {
        EnvironmentFile = secrets."music-import".path;
        ExecStart = lib.getExe pkgs.music-import;
        Group = "zach";
        Type = "oneshot";
        User = "zach";
      };
    };
  };
}
