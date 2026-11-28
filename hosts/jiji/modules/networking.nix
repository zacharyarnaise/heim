{config, ...}: {
  systemd.network = {
    netdevs."10-dummy0" = {
      netdevConfig = {
        Kind = "dummy";
        Name = "dummy0";
      };
    };
    networks."10-dummy0" = {
      name = "dummy0";
      addresses = [
        {
          Address = "${config.heim.net.services.atuin.ip}/32";
          Scope = "host";
        }
        {
          Address = "${config.heim.net.services.navidrome.ip}/32";
          Scope = "host";
        }
        {
          Address = "${config.heim.net.services.slskd.ip}/32";
          Scope = "host";
        }
        {
          Address = "${config.heim.net.services.nextcloud.ip}/32";
          Scope = "host";
        }
      ];
    };
  };
}
