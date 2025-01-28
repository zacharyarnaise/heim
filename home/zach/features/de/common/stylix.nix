{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;

    base16Scheme = "${inputs.tinted-theming}/base16/tokyo-night-moon.yaml";
    image = ../../../assets/13.jpeg;
    polarity = "dark";
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
        package = pkgs.unstable.nerd-fonts.mononoki;
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
        popups = 12;
        terminal = 14;
      };
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme.override {color = "indigo";};
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    opacity = {
      desktop = 0.75; # bars/widgets
    };
  };
}
