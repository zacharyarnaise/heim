{config, ...}: {
  wayland = {
    systemd.target = "hyprland-session.target";
    windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
    };
  };
  home.displaySessions = [config.wayland.windowManager.hyprland.finalPackage];

  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
        allow_token_by_default = true
    }
  '';
}
