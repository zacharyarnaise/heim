{
  lib,
  config,
  ...
}: {
  systemd.tmpfiles.rules = [
    "d /storage/media/torrents 0775 root media - -"
    "d /storage/media/torrents/.incomplete 0775 rtorrent rtorrent - -"
    "d /storage/media/torrents/manual 0775 rtorrent rtorrent - -"
    "d /storage/media/torrents/radarr 0775 rtorrent rtorrent - -"
    "d /storage/media/torrents/sonarr 0775 rtorrent rtorrent - -"
  ];

  users.users.rtorrent = {
    shell = lib.mkForce "/run/current-system/sw/bin/nologin";
    extraGroups = ["media"];
  };

  services.rtorrent = {
    enable = true;

    dataDir = "/persist/rtorrent";
    downloadDir = "/storage/media/torrents/.incomplete";
    group = "rtorrent";
    user = "rtorrent";
    openFirewall = true;
    port = 5000;
    configText = ''
      method.insert = d.get_finished_dir,simple,"cat=/storage/media/torrents/,$d.get_custom1="
      method.set_key = event.download.finished,move_complete,"d.set_directory=$d.get_finished_dir=;execute=mv,-u,$d.get_base_path=,$d.get_finished_dir="
    '';
  };
  systemd.services.rtorrent.serviceConfig = {
    # Always prioritize all other services wrt. IO
    IOSchedulingPriority = 7;
  };

  services.flood = {
    enable = true;
    openFirewall = true;
    host = "::";
    extraArgs = ["--rtsocket=${config.services.rtorrent.rpcSocket}"];
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
