{
  config,
  pkgs,
  ...
}: {
  xdg.portal = let
    hyprland = config.wayland.windowManager.hyprland.package;
    xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  in {
    extraPortals = [xdph];
    configPackages = [hyprland];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland.override {enableXWayland = false;};

    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
