{pkgs, ...}: let
  hyprland = pkgs.hyprland.override {wrapRuntimeDeps = false;};
in {
  imports = [
    ./hyprland_bindings.nix
    ./hyprland_settings.nix

    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  xdg.portal = let
    xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  in {
    configPackages = [hyprland];
    extraPortals = [xdph];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;

    xwayland.enable = false;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
