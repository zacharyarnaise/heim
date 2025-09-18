{pkgs, ...}: {
  home.packages = [pkgs.tidal-hifi];

  services.playerctld.enable = true;

  home.persistence = {
    "/persist" = {
      directories = [
        ".config/tidal-hifi"
      ];
    };
  };
}
