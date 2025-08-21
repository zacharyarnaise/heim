{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nixarr.nixosModules.default
  ];

  users.groups.media = {};

  sops.secrets = {
    "wg" = {};
  };
  nixarr = {
    enable = true;

    mediaDir = "/storage/media";
    stateDir = "/persist/nixarr";

    vpn = {
      enable = true;
      wgConf = config.sops.secrets."wg".path;
    };

    jellyfin.enable = true;
    bazarr.enable = true;
    sonarr.enable = true;
    radarr.enable = true;
    lidarr.enable = true;
    prowlarr.enable = true;
    jellyseerr.enable = true;
    transmission = {
      enable = true;
      openFirewall = false;
      vpn.enable = true;
      flood.enable = true;
    };
  };

  systemd.services.jellyseerr = {
    environment = {
      LOG_LEVEL = "info";
    };
  };
}
