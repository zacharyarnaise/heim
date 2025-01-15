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

    xwayland.enable = false;
    systemd = {
      enable = true;
      variables = ["--all"];
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    settings = {
      exec-once = [
        "hyprlock"
      ];
    };
  };
}
