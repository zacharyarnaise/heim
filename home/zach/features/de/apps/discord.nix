{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.vesktop];

  stylix.targets.vesktop.enable = true;

  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = false;
      directories = [
        ".config/vesktop/sessionData"
        ".config/vesktop/settings"
      ];
    };
  };
}
