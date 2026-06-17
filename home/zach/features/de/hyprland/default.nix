{config, ...}: {
  imports = [
    ./animations.nix
    ./bindings.nix
    ./config.nix
    ./rules
  ];

  wayland = {
    systemd.target = "hyprland-session.target";
    windowManager.hyprland = {
      enable = true;
      configType = "lua";
      systemd = {
        enable = true;
        enableXdgAutostart = true;
        extraCommands = [
          "systemctl --user stop hyprland-session.target"
          "systemctl --user reset-failed"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };
  };
  home.displaySessions = [config.wayland.windowManager.hyprland.finalPackage];

  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
        allow_token_by_default = true
    }
  '';
}
