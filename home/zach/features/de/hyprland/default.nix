{pkgs, ...}: {
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  xdg.portal = {
    config.hyprland.default = ["gtk" "hyprland"];
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland.override {wrapRuntimeDeps = false;};

    settings = {
      exec-once = [
        "uwsm finalize"
        "hyprlock"
      ];
    };

    # Conflicts with uwsm
    systemd.enable = false;
  };
}
