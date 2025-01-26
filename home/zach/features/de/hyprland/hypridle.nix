{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  hyprlock = "${config.programs.hyprlock.package}/bin/hyprlock";
  loginctl = "${pkgs.systemd}/bin/loginctl";
in {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "${hyprlock}";
        before_sleep_cmd = "${loginctl} lock-session";
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
      };

      listener = [
        # Lock after 5 minutes of inactivity
        {
          timeout = 300;
          on-timeout = "${loginctl} lock-session";
        }
        # Turn display off after 10 minutes of inactivity
        {
          timeout = 600;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
      ];
    };
  };

  systemd.user.services.hypridle = {
    Unit = {
      After = lib.mkForce "graphical-session.target";
    };
  };
}
