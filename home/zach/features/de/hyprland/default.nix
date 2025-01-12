{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprlock.nix
  ];

  xdg.portal = {
    config.common.default =
      ["hyprland"] ++ config.xdg.portal.config.common.default;
    extraPortals =
      [pkgs.xdg-desktop-portal-hyprland] ++ config.xdg.portal.extraPortals;
  };
}
