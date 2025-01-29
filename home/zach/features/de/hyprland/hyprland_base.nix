{
  config,
  pkgs,
  ...
}: {
  xdg.portal = {
    configPackages = [config.wayland.windowManager.hyprland.finalPackage];
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    enableXWayland = false;
    package = pkgs.hyprland;

    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
