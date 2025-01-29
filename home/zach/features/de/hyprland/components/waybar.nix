{
  lib,
  config,
  pkgs,
  ...
}: let
  loginctl = "${pkgs.systemd}/bin/loginctl";
  systemctl = "${pkgs.systemd}/bin/systemctl";
in {
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
        ];
        modules-center = [
          "temperature"
          "cpu"
          "clock"
          "memory"
        ];
        modules-right = [
          "group/power"
        ];

        # ------------------------------- Center -------------------------------
        temperature = {
          interval = 5;
          hwmon-path = "/sys/class/hwmon/hwmon5/temp1_input";
          format = "<span weight='bold'>󰏈</span> {temperatureC:3}°C";
        };
        cpu = {
          format = "<span weight='bold'></span> {usage:3}%";
          interval = 5;
        };
        memory = {
          format = "<span weight='bold'></span> {used:4.1f}G/{total:.2g}G";
          interval = 10;
        };
        clock = {
          interval = 1;
          format = "{:L%H:%M:%S}";
          on-click-left = "mode";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 0;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>S{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        # ------------------------------- Right -------------------------------
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
        font-family: "${config.stylix.fonts.monospace.name}";
        padding: 0;
        margin: 0;
      }
      window#waybar, tooltip {
        border-radius: 0.5em;
      }
      .modules-center {
        padding-right: 2em;
      }
      window#waybar {
        border: 0.05em solid @base0D;
      }
      #clock, #custom-hostname {
        border-radius: 0.6em;
        background-color: alpha(@base0D, 0.9);
      }

      #temperature, #cpu {
        margin-right: 0.6em;
      }
      #memory {
        margin-left: 0.6em;
      }
      #clock {
        min-width: 4.5em;
        font-size: 11pt;
        font-weight: 600;
        padding-right: 0.8em;
        padding-left: 0.8em;
      }

      #custom-hostname {
        font-family: "${config.stylix.fonts.sansSerif.name}";
        font-size: 10pt;
        min-width: 9em;
      }
      .group-power-element > * {
        min-width: 1.4em;
        font-size: 1.3em;
        color: @base07;
        background-color: alpha(@base0D, 0.2);
        border-radius: 0.1em;
      }
      .group-power-element > *:hover {
        transition: 0.2s;
        color: @base09;
        background-color: alpha(@base0D, 0.4);
        border-radius: 0.2em;
      }
    '';
  };
}
