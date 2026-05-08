{pkgs, ...}: {
  home.packages = [pkgs.feishin];

  services.playerctld.enable = true;

  home.persistence = {
    "/persist" = {
      directories = [
        ".config/feishin"
      ];
    };
  };
}
