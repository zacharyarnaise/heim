{
  lib,
  config,
  inputs,
  ...
}: let
  downloadDir = "/storage/media/torrents";
  portRange = inputs.secrets.hosts.kamaji.rtorrentPortRange;
in {
  users.users.rtorrent = {
    shell = lib.mkForce "/run/current-system/sw/bin/nologin";
  };

  networking.firewall = let
    ports = lib.strings.splitString "-" portRange;
    from = lib.toInt (lib.head ports);
    to = lib.toInt (lib.last ports);
  in {
    allowedTCPPortRanges = [
      {
        from = from;
        to = to;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = from;
        to = to;
      }
    ];
  };

  services.rtorrent = {
    enable = true;

    dataDir = "/persist/rtorrent";
    downloadDir = "${downloadDir}/.incomplete";
    group = "rtorrent";
    user = "rtorrent";
    openFirewall = false; # Done manually
    configText = ''
      method.redirect=load.throw,load.normal
      method.redirect=load.start_throw,load.start
      method.insert=d.down.sequential,value|const,0
      method.insert=d.down.sequential.set,value|const,0

      method.insert = in_category, simple|private, "equal={d.custom1=,argument.0=}"
      method.set_key = event.download.inserted_new, default_label, "branch=in_category=,d.custom1.set=manual"
      method.insert = d.data_path, simple, "if=(d.is_multi_file), (cat, (d.directory), /), (cat, (d.directory), /, (d.name))"
      method.insert = d.finished_path, simple, "cat=${downloadDir}/,$d.custom1="
      method.insert = d.move_to_finished, simple, "d.directory.set=$argument.1=; execute=mkdir,-p,$argument.1=; execute=mv,-u,$argument.0=,$argument.1=; d.save_full_session="
      method.set_key = event.download.finished, move_finished, "d.move_to_finished=$d.data_path=,$d.finished_path="

      network.port_range.set = ${portRange}
      network.port_random.set = yes
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

      throttle.global_down.max_rate.set = 0
      throttle.global_up.max_rate.set = 0
      throttle.max_downloads.global.set = 300
      throttle.max_uploads.global.set = 500
      throttle.max_downloads.set = 100
      throttle.max_uploads.set = 50
      throttle.min_peers.normal.set = 100
      throttle.max_peers.normal.set = 200
      throttle.min_peers.seed.set = 1
      throttle.max_peers.seed.set = 100
      trackers.numwant.set = 100
      trackers.use_udp.set = yes
    '';
  };

  services.flood = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    extraArgs = ["--noauth --rtsocket=${config.services.rtorrent.rpcSocket}"];
  };
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib/private/flood"
    ];
  };

  systemd = {
    tmpfiles.rules = [
      "d ${downloadDir} 0775 root root - -"
      "d ${downloadDir}/.incomplete 0755 rtorrent rtorrent - -"
      "d ${downloadDir}/manual 0755 rtorrent rtorrent - -"
      "d ${downloadDir}/radarr 0755 rtorrent rtorrent - -"
      "d ${downloadDir}/sonarr 0755 rtorrent rtorrent - -"
    ];

    services.rtorrent.serviceConfig = {
      # Always prioritize all other services wrt. IO
      IOSchedulingPriority = 7;
      LimitNOFILE = 4096;
    };
    services.flood = {
      after = ["rtorrent.service"];
      wants = ["rtorrent.service"];
      serviceConfig = {
        User = "rtorrent";
        Group = "rtorrent";
      };
    };
  };
}
