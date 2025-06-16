{inputs, ...}: {
  imports = [
    inputs.nixarr.nixosModules.default

    ./rtorrent.nix
  ];

  users.groups.media = {};

  systemd.tmpfiles.rules = [
    "d /storage/media 0770 root media - -"
  ];

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
