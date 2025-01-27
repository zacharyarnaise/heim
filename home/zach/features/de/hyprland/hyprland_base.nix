{
  config,
  pkgs,
  ...
}: {
  xdg.portal = {
    configPackages = [config.wayland.windowManager.hyprland.package];
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
