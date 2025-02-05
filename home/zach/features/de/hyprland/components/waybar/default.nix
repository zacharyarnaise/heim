{
  lib,
  config,
  pkgs,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  systemctl = "${pkgs.systemd}/bin/systemctl";
in {
  home.packages = [pkgs.nerd-fonts.departure-mono];
  stylix.targets.waybar.addCss = false;

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        name = "main-bar";
        layer = "top";
        position = "top";
        height = 35;
        margin = "8 10 4 10";
        mode = "dock";
        exclusive = true;
        passthrough = false;

        modules-left = [
          "custom/nix"
          "custom/separator"
          "memory"
          "cpu"
          "temperature"
          "battery"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "group/power"
        ];

        "custom/separator" = {
          interval = "once";
          tooltip = false;
          format = "  ";
        };

        # -------------------------------- Left --------------------------------
        "custom/nix" = {
          format = "󱄅";
        };
        memory = {
          interval = 10;
          format = "{icon} {used:4.1f}G/{total:.2g}G";
          format-icons = [""];
        };
        cpu = {
          interval = 10;
          format = "{icon} {usage:3}%";
          format-icons = [""];
        };
        temperature = {
          interval = 10;
          hwmon-path = "/sys/class/hwmon/hwmon5/temp1_input";
          format = "{icon} {temperatureC:2}°C";
          format-icons = ["󰏈"];
        };

        # ------------------------------- Center -------------------------------
        "hyprland/workspaces" = {
          on-click = "activate";
          on-scroll-up = "${hyprctl} dispatch workspace e+1";
          on-scroll-down = "${hyprctl} dispatch workspace e-1";
          show-special = false;
          format = "{icon}";
          format-icons = {
            empty = "";
            default = "󰊠";
            active = "󰮯";
            urgent = "";
          };
        };

        # ------------------------------- Right -------------------------------
        battery = {
          full-at = 98;
          interval = 60;
          states.warning = 30;
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format = "{icon} {capacity:3}%";
          format-charging = "󰢝 {capacity:3}%";
          format-plugged = "󰚥 {capacity:3}%";
          onclick = "";
        };
        "group/power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 400;
            transition-left-to-right = false;
            children-class = "group-power-element";
          };
          modules = [
            "clock"
            "custom/lock"
            "custom/sleep"
            "custom/poweroff"
            "custom/reboot"
            "custom/reboot-uefi"
          ];
        };
        clock = {
          interval = 1;
          format = "{:%H:%M:%S}";
          on-click-left = "mode";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };
        "custom/lock" = {
          on-click = "${loginctl} lock-session";
          format = "󰌾";
          tooltip = false;
        };
        "custom/sleep" = {
          on-click = "${systemctl} sleep";
          format = "󰤄";
          tooltip = false;
        };
        "custom/poweroff" = {
          on-click = "${systemctl} poweroff";
          format = "󰐥";
          tooltip = false;
        };
        "custom/reboot" = {
          on-click = "${systemctl} reboot";
          format = "󰜉";
          tooltip = false;
        };
        "custom/reboot-uefi" = {
          on-click = "${systemctl} reboot --firmware-setup";
          format = "󱄌";
          tooltip = false;
        };
      };
    };

    style = lib.mkAfter ./style.css;
  };
}
