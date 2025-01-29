{
  config,
  pkgs,
  ...
}: let
  hyprlandOverride = pkgs.hyprland.override {
    hyprcursor = pkgs.unstable.hyprcursor;
    enableXWayland = false;
  };
in {
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprlandOverride;

    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  xdg.portal = let
    hyprlandFinal = config.wayland.windowManager.hyprland.finalPackage;
    xdph = pkgs.xdg-desktop-portal-hyprland.override {
      hyprland = hyprlandFinal;
    };
  in {
    configPackages = [hyprlandFinal];
    extraPortals = [xdph];
  };
}
