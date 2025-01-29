{
  config,
  pkgs,
  ...
}: let
  hyprlandOverride = pkgs.hyprland;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprlandOverride;

    xwayland.enable = false;
    settings.xwayland.enabled = false;

    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  xdg.portal = let
    xdph = pkgs.xdg-desktop-portal-hyprland.override {
      hyprland = config.wayland.windowManager.hyprland.finalPackage;
    };
  in {
    configPackages = [config.wayland.windowManager.hyprland.finalPackage];
    extraPortals = [xdph];
  };
}
