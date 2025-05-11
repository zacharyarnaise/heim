{lib, ...}: {
  qt = {
    enable = true;

    platformTheme = {
      name = lib.mkDefault "gtk3";
    };
  };

  stylix.targets.qt.enable = true;
}
