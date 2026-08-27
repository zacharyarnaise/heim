{config, ...}: let
  inherit (config.sops) secrets;
in {
  sops.secrets."slskd" = {
    group = "slskd";
    owner = "slskd";
  };

  services.slskd = {
    enable = true;
    domain = null; # Disable nginx vhost
    openFirewall = true;

    environmentFile = secrets."slskd".path;
    # https://github.com/slskd/slskd/blob/master/config/slskd.example.yml
    settings = {
      remote_configuration = false;

      flags = {
        force_share_scan = false;
        no_config_watch = true;
        no_version_check = true;
      };

      directories = {
        downloads = "/storage/data01/slskd/downloads";
        incomplete = "/storage/data01/slskd/incomplete";
      };

      shares = {
        directories = ["/storage/sb01/music"];
        filters = ["\\.ini$" "Thumbs\\.db$" "\\.DS_Store$" "\\.nfo$"];
      };

      transfers = {
        download = {
          slots = 100;
        };
        upload = {
          slots = 10;
          speed_limit = 20000;
          limits = {
            queued = {
              files = 100;
              megabytes = 5000;
            };
            daily = null;
            weekly = {
              files = 2000;
              megabytes = 20000;
              failures = 100;
            };
          };
        };
        groups.leechers.upload = {
          slots = 2;
          speed_limit = 2000;
          limits = {
            queued = {
              files = 20;
              megabytes = 500;
            };
            daily = null;
            weekly = {
              files = 100;
              megabytes = 1000;
              failures = 10;
            };
          };
        };
      };

      web = {
        ip_address = "10.0.1.3";
        port = 5030;
      };
    };
  };

  systemd = {
    services.slskd = {
      after = ["storage-sb01-music.mount"];
      unitConfig.RequiresMountsFor = "/storage/sb01/music";
      serviceConfig = {
        CPUWeight = 20;
        IOSchedulingClass = "idle";
        IOWeight = 10;
        Nice = 19;
      };
    };

    tmpfiles.rules = [
      "d /storage/data01/slskd            0755 slskd slskd -"
      "d /storage/data01/slskd/downloads  0755 slskd slskd -"
      "d /storage/data01/slskd/incomplete 0755 slskd slskd -"
    ];
  };

  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/slskd";
      group = "slskd";
      mode = "0700";
      user = "slskd";
    }
  ];
}
