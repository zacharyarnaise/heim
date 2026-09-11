{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (config.sops) secrets;
  inherit (inputs.secrets.hosts."jiji") acme;
in {
  sops.secrets = {
    "acme-nxc" = {};
    "nextcloud" = {
      group = "nextcloud";
      owner = "nextcloud";
    };
  };

  networking.firewall.interfaces.wg0.allowedTCPPorts = [80 443];

  security.acme = {
    acceptTerms = true;
    defaults.email = acme.email;
    certs.${acme.domain} = {
      inherit (acme) dnsProvider dnsResolver;
      environmentFile = secrets."acme-nxc".path;
      group = "nginx";
    };
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud34;

    configureRedis = false;
    database.createLocally = true;
    home = "/storage/data01/nextcloud";
    hostName = acme.domain;
    https = true;
    settings.trusted_domains = ["10.0.1.4"];

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

  services.nginx.virtualHosts.${acme.domain} = {
    forceSSL = true;
    listenAddresses = ["10.0.1.4"];
    useACMEHost = acme.domain;
  };
}
