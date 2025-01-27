{pkgs, ...}: {
  imports = [
    ./hyprland_bindings.nix
    ./hyprland_settings.nix

    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  xdg.portal = {
    #configPackages = [pkgs.hyprland];
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = false;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
