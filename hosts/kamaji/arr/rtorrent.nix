{
  lib,
  config,
  ...
}: let
  downloadDir = "/storage/media/torrents";
in {
  systemd.tmpfiles.rules = [
    "d ${downloadDir} 0755 root root - -"
    "d ${downloadDir}/.incomplete 0755 rtorrent rtorrent - -"
    "d ${downloadDir}/manual 0755 rtorrent rtorrent - -"
    "d ${downloadDir}/radarr 0755 rtorrent rtorrent - -"
    "d ${downloadDir}/sonarr 0755 rtorrent rtorrent - -"
  ];

  users.users.rtorrent = {
    shell = lib.mkForce "/run/current-system/sw/bin/nologin";
  };

  services.rtorrent = {
    enable = true;

    dataDir = "/persist/rtorrent";
    downloadDir = "${downloadDir}/.incomplete";
    group = "rtorrent";
    user = "rtorrent";
    openFirewall = true;
    port = 5000;
    configText = ''
      method.insert = d.data_path, simple, "if=(d.is_multi_file), (cat, (d.directory), /), (cat, (d.directory), /, (d.name))"
      method.insert = d.finished_path, simple, "cat=${downloadDir}/,$d.custom1="
      method.insert = d.move_to_finished, simple, "d.directory.set=$argument.1=; execute=mkdir,-p,$argument.1=; execute=mv,-u,$argument.0=,$argument.1=; d.save_full_session="
      method.set_key = event.download.finished, move_finished, "d.move_to_finished=$d.data_path=,$d.finished_path="

      network.receive_buffer.size.set = 4M
      network.send_buffer.size.set = 16M
      pieces.memory.max.set = 4G
      pieces.preload.type.set = 1
      system.file.allocate.set = 1
      system.files.advise_random.set = true
      system.files.advise_random.hashing.set = false

      schedule_remove2 = monitor_diskspace
      schedule2 = session_save, 900, 14400, ((session.save))
      system.umask.set = 0022

      throttle.max_downloads.global.set = 500
      throttle.max_uploads.global.set = 1000
      throttle.max_downloads.set = 100
      throttle.max_uploads.set = 50
      throttle.min_peers.normal.set = 80
      throttle.max_peers.normal.set = 200
      throttle.min_peers.seed.set = -1
      throttle.max_peers.seed.set = -1
      trackers.numwant.set = 100
    '';
  };
  systemd.services.rtorrent.serviceConfig = {
    # Always prioritize all other services wrt. IO
    IOSchedulingPriority = 7;
    LimitNOFILE = 4096;
  };

  services.flood = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    extraArgs = ["--auth none --rtsocket=${config.services.rtorrent.rpcSocket}"];
  };
  systemd.services.flood = {
    after = ["rtorrent.service"];
    wants = ["rtorrent.service"];
    serviceConfig = {
      User = "rtorrent";
      Group = "rtorrent";
    };
  };
}
