{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.tidal-hifi];

  services.playerctld.enable = true;

  home.persistence = {
    "/persist${config.home.homeDirectory}" = {
      directories = [
        ".config/tidal-hifi"
      ];
    };
  };
}
