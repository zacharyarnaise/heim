{
  config,
  pkgs,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.finalPackage}/bin/hyprctl";
  hyprlock = "${config.programs.hyprlock.package}/bin/hyprlock";
  loginctl = "${pkgs.systemd}/bin/loginctl";

  baseTimeout =
    if config.hostSpec.kind == "laptop"
    then 300
    else 900;
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
        # Lock after 5 minutes on laptops, 15 minutes elsewhere
        {
          timeout = baseTimeout;
          on-timeout = "${loginctl} lock-session";
        }
        # Display off after 10 minutes on laptops, 30 minutes elsewhere
        {
          timeout = baseTimeout * 2;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
      ];
    };
  };
}
