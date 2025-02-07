{lib, ...}: {
  qt = {
    enable = true;

    platformTheme = {
      name = lib.mkDefault "gtk3";
    };
  };
}
