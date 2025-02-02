{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      wf-recorder
      wl-clipboard
      ;
  };

  home.sessionVariables = {
    LIBSEAT_BACKEND = "logind";
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_WEBRENDER = 1;
    NIXOS_OZONE_WL = 1;
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}
