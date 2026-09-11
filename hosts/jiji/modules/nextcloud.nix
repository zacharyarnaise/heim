{
  config,
  inputs,
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
    "nextcloud/admin" = nextcloud;
    "nextcloud/config" = nextcloud;
    "nextcloud/s3" = nextcloud;
    "nextcloud/sse-c" = nextcloud;
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

    configureRedis = false;
    database.createLocally = true;
    home = "/storage/data01/nextcloud";
    hostName = flakeSecrets.acme.domain;
    https = true;
    secretFile = secrets."nextcloud/config".path;
    settings.trusted_domains = ["10.0.1.4"];

    config = {
      adminpassFile = secrets."nextcloud/admin".path;
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
  };

  services.nginx.virtualHosts.${flakeSecrets.acme.domain} = {
    forceSSL = true;
    listenAddresses = ["10.0.1.4"];
    useACMEHost = flakeSecrets.acme.domain;
  };
}
