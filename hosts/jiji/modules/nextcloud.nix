{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (config.sops) secrets;
  flakeSecrets = inputs.secrets.hosts."jiji";
in {
  sops.secrets = let
    nextcloud = {
      group = "nextcloud";
      owner = "nextcloud";
    };
  in {
    "acme-nextcloud" = {};
    "nextcloud/automation" = {};

    "nextcloud/admin" = nextcloud;
    "nextcloud/config" = nextcloud;
    "nextcloud/s3" = nextcloud;
    "nextcloud/sse-c" = nextcloud;
  };

  systemd = {
    services.nextcloud-deck_daily = {
      after = [
        "network-online.target"
        "phpfpm-nextcloud.service"
      ];
      wants = ["network-online.target"];
      unitConfig.StartLimitBurst = 3;
      serviceConfig = {
        DynamicUser = true;
        EnvironmentFile = secrets."nextcloud/automation".path;
        ExecStart = lib.getExe pkgs.nextcloud-deck_daily;
        Restart = "on-failure";
        RestartSec = 60;
        Type = "oneshot";
      };
    };

    timers.nextcloud-deck_daily = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "*-*-* 06:00:00";
        Persistent = true;
      };
    };
  };

  networking.firewall.interfaces.wg0.allowedTCPPorts = [80 443];

  security.acme = {
    acceptTerms = true;
    defaults.email = flakeSecrets.acme.email;
    certs.${flakeSecrets.acme.domain} = {
      inherit (flakeSecrets.acme) dnsProvider dnsResolver;
      environmentFile = secrets."acme-nextcloud".path;
      group = "nginx";
    };
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud34;

    autoUpdateApps.enable = true;
    database.createLocally = true;
    home = "/storage/data01/nextcloud";
    hostName = flakeSecrets.acme.domain;
    https = true;
    phpOptions."opcache.interned_strings_buffer" = 32;
    secretFile = secrets."nextcloud/config".path;

    config = {
      adminpassFile = secrets."nextcloud/admin".path;
      adminuser = "zach";
      dbtype = "pgsql";

      objectstore.s3 = {
        enable = true;
        bucket = "";
        key = "";
        secretFile = secrets."nextcloud/s3".path;
        sseCKeyFile = secrets."nextcloud/sse-c".path;
        usePathStyle = true;
        useSsl = true;
      };
    };

    poolSettings = {
      pm = "dynamic";
      "pm.max_children" = "8";
      "pm.max_requests" = "500";
      "pm.max_spare_servers" = "3";
      "pm.min_spare_servers" = "1";
      "pm.start_servers" = "2";
    };

    settings = {
      maintenance_window_start = 1;
      trusted_domains = ["10.0.1.4"];
    };
  };

  services.nginx.virtualHosts.${flakeSecrets.acme.domain} = {
    forceSSL = true;
    listenAddresses = ["10.0.1.4"];
    useACMEHost = flakeSecrets.acme.domain;
  };
}
