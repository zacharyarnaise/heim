{pkgs, ...}: let
  hyprland = pkgs.hyprland.override {enableXWayland = false;};
in {
  xdg.portal = let
    xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  in {
    configPackages = [hyprland];
    extraPortals = [xdph];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;

    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
