{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  xdg.portal = {
    config.hyprland.default = ["gtk" "hyprland"];
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland.override {wrapRuntimeDeps = false;};

    settings = {
      exec-once = [
        "uwsm finalize"
        "hyprlock"
      ];
    };

    systemd = {
      enable = false;
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
