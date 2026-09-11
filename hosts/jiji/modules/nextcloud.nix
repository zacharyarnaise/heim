{
  config,
  pkgs,
  ...
}: let
  inherit (config.sops) secrets;
in {
  sops.secrets."nextcloud" = {
    group = "nextcloud";
    owner = "nextcloud";
  };

  networking.firewall.interfaces.wg0.allowedTCPPorts = [80];

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud34;

    configureRedis = false;
    database.createLocally = true;
    home = "/storage/data01/nextcloud";
    hostName = "10.0.1.4";

    config = {
      adminpassFile = secrets."nextcloud".path;
      dbtype = "pgsql";
    };

    poolSettings = {
      pm = "dynamic";
      "pm.max_children" = "8";
      "pm.max_requests" = "500";
      "pm.max_spare_servers" = "3";
      "pm.min_spare_servers" = "1";
      "pm.start_servers" = "2";
    };
  };

  services.nginx.virtualHosts."10.0.1.4".listen = [
    {
      addr = "10.0.1.4";
      port = 80;
    }
  ];
}
