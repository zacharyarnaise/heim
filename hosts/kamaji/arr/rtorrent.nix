{
  lib,
  config,
  ...
}: let
  downloadDir = "/storage/media/torrents";
in {
  systemd.tmpfiles.rules = [
    "d ${downloadDir} 0775 root media - -"
    "d ${downloadDir}/.incomplete 0775 rtorrent rtorrent - -"
    "d ${downloadDir}/manual 0775 rtorrent rtorrent - -"
    "d ${downloadDir}/radarr 0775 rtorrent rtorrent - -"
    "d ${downloadDir}/sonarr 0775 rtorrent rtorrent - -"
  ];

  users.users.rtorrent = {
    shell = lib.mkForce "/run/current-system/sw/bin/nologin";
    extraGroups = ["media"];
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
