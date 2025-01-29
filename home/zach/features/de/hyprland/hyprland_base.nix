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
    package = pkgs.hyprland;

    enableXWayland = false;
    settings.xwayland.enabled = false;

    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
