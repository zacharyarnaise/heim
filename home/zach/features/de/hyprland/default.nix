{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hyprland_bindings.nix
    ./hyprland_settings.nix

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

    xwayland.enable = false;
    systemd = {
      enable = true;
      variables = ["--all"];
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
