{
  nixarr = {
    enable = true;

    mediaDir = "/storage/media";
    stateDir = "/persist/nixarr";

    jellyfin.enable = true;
    transmission.enable = false;
    bazarr.enable = true;
    sonarr.enable = true;
    radarr.enable = true;
    prowlarr.enable = true;
    jellyseerr = {
      enable = true;
      port = 9096;
    };
  };
}
