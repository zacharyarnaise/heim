{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    image = ../../../wallpapers/l8kmop.png;
    cursor = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
      size = 24;
    };
    fonts = {
      emoji = {
        package = pkgs.openmoji-color;
        name = "OpenMoji Color";
      };
      monospace = {
        package = pkgs.nerd-fonts.mononoki;
        name = "Mononoki Nerd Font";
      };

      sansSerif = {
        package = pkgs.fira;
        name = "Fira Sans";
      };

      serif = {
        package = pkgs.fira;
        name = "Fira Sans";
      };

      sizes = {
        applications = 12;
        desktop = 11;
        popups = 9;
        terminal = 12;
      };
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme.override {color = "indigo";};
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    opacity = {
      applications = 0.9;
      desktop = 0.4;
      popups = 0.6;
      terminal = 0.6;
    };
    targets = {
      # https://github.com/danth/stylix/issues/253
      gnome.enable = true;
    };
  };
}
