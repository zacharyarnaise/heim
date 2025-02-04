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

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
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
          "hyprland/workspaces"
        ];
        modules-center = [
          "temperature"
          "cpu"
          "clock"
          "memory"
        ];
        modules-right = [
          "battery"
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

        # ------------------------------- Center -------------------------------
        temperature = {
          interval = 10;
          hwmon-path = "/sys/class/hwmon/hwmon5/temp1_input";
          format = "{icon} {temperatureC:2}°C";
          format-icons = ["󰏈"];
        };
        cpu = {
          interval = 10;
          format = "{icon} {usage:3}%";
          format-icons = [""];
        };
        memory = {
          interval = 10;
          format = "{icon} {used:4.1f}G/{total:.2g}G";
          format-icons = [""];
        };
        clock = {
          interval = 1;
          format = "{:%H:%M:%S}";
          on-click-left = "mode";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
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
            "custom/hostname"
            "custom/lock"
            "custom/sleep"
            "custom/poweroff"
            "custom/reboot"
            "custom/reboot-uefi"
          ];
        };
        "custom/hostname" = {
          exec = "echo $USER@$HOSTNAME";
          interval = "once";
          tooltip = false;
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

    style = lib.mkAfter ''
      * {
        font-family: "DepartureMono";
        font-weight: bold;
        padding: 0;
        margin: 0;
      }
      window#waybar,
      window#waybar.empty,
      window#waybar.empty #window {
        background-color: transparent;
        border: 0;
      }
      tooltip {
        opacity: 0.75;
        border-radius: 0.6em;
        border-width: 0.08em;
        border-style: solid;
        border-color: @base0D;
      }
      tooltip label{
        color: @base05;
      }

      .modules-left, .modules-center, .modules-right {
        background-color: alpha(@base00, 0.4)
        color: @base05;
        border-bottom: 0.05em;
        border-style: solid;
        border-color: @base0D;
        border-radius: 0.6em;
        padding: 0.3em 0.6em 0.3em 0.6em;
      }

      #taskbar button,
      #workspaces button {
        color: dimgrey;
          box-shadow: none;
        text-shadow: none;
          padding: 0px;
          border-radius: 9px;
          padding-left: 4px;
          padding-right: 4px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
      }
      #taskbar button:hover,
      #workspaces button:hover {
        color: white;
        background-color: #7f849c;
          padding-left: 2px;
          padding-right: 2px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #taskbar button.active,
      #workspaces button.active {
        color: white;
          padding-left: 8px;
          padding-right: 8px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.persistent {
        border-radius: 10px;
      }

      #backlight,
      #backlight-slider,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #disk,
      #idle_inhibitor,
      #keyboard-state,
      #memory,
      #mode,
      #mpris,
      #network,
      #power-profiles-daemon,
      #pulseaudio,
      #pulseaudio-slider,
      #taskbar,
      #temperature,
      #tray,
      #window,
      #wireplumber,
      #workspaces,
      #custom-backlight,
      #custom-browser,
      #custom-cava_mviz,
      #custom-cycle_wall,
      #custom-file_manager,
      #custom-keybinds,
      #custom-keyboard,
      #custom-light_dark,
      #custom-lock,
      #custom-hint,
      #custom-hypridle,
      #custom-menu,
      #custom-playerctl,
      #custom-power_vertical,
      #custom-power,
      #custom-settings,
      #custom-spotify,
      #custom-swaync,
      #custom-tty,
      #custom-updater,
      #custom-weather,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.default,
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.severe,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.sunnyDay {
        padding-top: 4px;
        padding-bottom: 4px;
        padding-right: 6px;
        padding-left: 6px;
      }
      /*-----Indicators----*/
      #custom-hypridle.notactive,
      #idle_inhibitor.activated {
        color: #39FF14;
      }

      #pulseaudio.muted {
        color: #cc3436;
      }
      #temperature.critical {
        color: red;
      }

      @keyframes blink {
        to {
          color: #000000;
        }
      }

      #battery.critical:not(.charging) {
        color: #f53c3c;
        animation-name: blink;
        animation-duration: 3.0s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #backlight-slider slider,
      #pulseaudio-slider slider {
        min-width: 0px;
        min-height: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }

      #backlight-slider trough,
      #pulseaudio-slider trough {
        min-width: 80px;
        min-height: 5px;
        border-radius: 5px;
      }

      #backlight-slider highlight,
      #pulseaudio-slider highlight {
        min-height: 10px;
        border-radius: 5px;
      }
    '';
  };
}
