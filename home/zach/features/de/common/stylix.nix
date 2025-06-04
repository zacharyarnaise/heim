{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.homeModules.stylix];

  stylix = {
    enable = true;
    overlays.enable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    image = ../../../wallpapers/q26ogl.jpg;
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
        popups = 10;
        terminal = 12;
      };
    };
    iconTheme = {
      enable = true;
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    opacity = {
      applications = 0.9;
      desktop = 0.6;
      popups = 0.75;
      terminal = 0.75;
    };
  };
}
