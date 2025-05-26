{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.tidal-hifi];

  home.persistence = {
    "/persist${config.home.homeDirectory}" = {
      directories = [
        ".config/tidal-hifi"
      ];
    };
  };
}
