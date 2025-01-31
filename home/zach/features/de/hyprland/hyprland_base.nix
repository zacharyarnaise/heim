{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
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
