{pkgs, ...}: let
  hyprland = pkgs.hyprland.override {wrapRuntimeDeps = false;};
in {
  wayland.windowManager.hyprland.package = hyprland;

  imports = [
    ./hyprland_bindings.nix
    ./hyprland_settings.nix

    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  xdg.portal = {
    configPackages = [hyprland];

    extraPortals = let
      xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
    in [xdph];
    config.hyprland.default = ["gtk" "hyprland"];
  };

  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = false;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
