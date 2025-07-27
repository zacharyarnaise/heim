{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.feishin];

  services.playerctld.enable = true;

  home.persistence = {
    "/persist${config.home.homeDirectory}" = {
      directories = [
        ".config/feishin"
      ];
    };
  };
}
