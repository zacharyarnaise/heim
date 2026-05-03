{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixarr.nixosModules.default
  ];

  sops.secrets."wg0" = {};
  users.groups.media = {};

  nixarr = {
    enable = true;

    mediaDir = "/storage/media";
    stateDir = "/persist/nixarr";
    vpn = {
      enable = true;
      wgConf = config.sops.secrets."wg0".path;
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      openFirewall = true;
    };
    lidarr = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    qbittorrent = {
      enable = true;
      qui.enable = true;
      vpn.enable = true;

      openFirewall = true;
    };
  };

  services.qbittorrent.serverConfig = {
    Application.MemoryWorkingSetLimit = 1024;
    BitTorrent = {
      "MergeTrackersEnabled" = true;
      "Session\\DiskIOType" = "MMap";
      "Session\\DiskQueueSize" = 4194304;
      "Session\\HashingThreadsCount" = 4;
      "Session\\MaxActiveCheckingTorrents" = 1;
      "Session\\MaxActiveDownloads" = lib.mkForce 20;
      "Session\\MaxActiveTorrents" = lib.mkForce 20;
      "Session\\MaxActiveUploads" = lib.mkForce 5;
    };
    LegalNotice.Accepted = true;
    Network.PortForwardingEnabled = false;
    Preferences = {
      "Connection\\NATPMPEnabled" = false;
      "Connection\\UPnP" = false;
      "General\\StatusbarExternalIPDisplayed" = true;
      "WebUI\\AuthSubnetWhitelist" = lib.mkForce "192.168.1.0/20";
    };
  };
  systemd = {
    # Set log level to reduce noise in journalctl
    services = {
      jellyseerr.environment.LOG_LEVEL = "warn";
      lidarr.environment.LIDARR__LOG__LEVEL = "Warn";
      prowlarr.environment.PROWLARR__LOG__LEVEL = "Warn";
      radarr.environment.RADARR__LOG__LEVEL = "Warn";
      sonarr.environment.SONARR__LOG__LEVEL = "Warn";
    };

    services.qbittorrent-port-forward = {
      description = "NAT-PMP port forwarding for qBittorrent";
      after = ["qbittorrent.service"];
      bindsTo = [
        "wg.service"
        "qbittorrent.service"
      ];
      unitConfig = {
        JoinsNamespaceOf = "qbittorrent.service";
        StopWhenUnneeded = true;
      };
      serviceConfig = {
        Group = "media";
        User = "qbittorrent";
        PrivateNetwork = true;
        Restart = "no";
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "qbittorrent-port-forward" ''
          natpmpc_out=$(${pkgs.libnatpmp}/bin/natpmpc -a 1 0 tcp 60 -g 10.2.0.1 2>&1) || true
          ${pkgs.libnatpmp}/bin/natpmpc -a 1 0 udp 60 -g 10.2.0.1 > /dev/null 2>&1 || true
          mapped_port=$(echo "$natpmpc_out" | grep "Mapped public port" | ${pkgs.gawk}/bin/awk '{print $4}')

          if [ -z "$mapped_port" ]; then
            printf 'naptpmc failed. Output:\n%s\n' "$natpmpc_out"
            exit 1
          fi

          printf 'natpmpc succeeded, mapped public port: %s\n' "$mapped_port"

          ${pkgs.curl}/bin/curl -fs -X POST http://192.168.15.1:8085/api/v2/app/setPreferences \
            --data-urlencode "json={\"listen_port\": $mapped_port}" \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -o /dev/null || {
              echo "qBittorrent setPreferences API call failed."
              exit 1
            }

          echo "Success, exiting."
        '';
      };
    };
    timers.qbittorrent-port-forward = {
      description = "qBittorrent port forwarding timer";
      after = ["qbittorrent.service"];
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "45s";
      };
    };
  };
}
