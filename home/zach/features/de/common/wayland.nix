{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      wf-recorder
      wl-clipboard
      ;
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_WEBRENDER = 1;
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';
}
