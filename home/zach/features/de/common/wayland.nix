{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      wl-clipboard
      ;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };
}
