{pkgs, ...}: {
  home.packages = [pkgs.feishin];

  programs.mpv.enable = true; # I use it as the audio backend
  services.playerctld.enable = true;

  home.persistence = {
    "/persist" = {
      directories = [
        ".config/feishin"
      ];
    };
  };
}
