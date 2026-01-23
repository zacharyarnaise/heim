{pkgs, ...}: {
  home.packages = [pkgs.feishin-mpv-unwrapped];

  services.playerctld.enable = true;

  home.persistence = {
    "/persist" = {
      directories = [
        ".config/feishin"
      ];
    };
  };
}
