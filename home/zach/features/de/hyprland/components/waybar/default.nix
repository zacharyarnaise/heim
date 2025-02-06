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
          "cpu"
          "memory"
          "temperature"
          "battery"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "tray"
          "group/applets"
          "custom/separator"
          "clock"
        ];

        "custom/separator" = {
          format = "";
          interval = "once";
        };

        # -------------------------------- Left --------------------------------
        "custom/nix" = {
          format = "󱄅";
          tooltip = false;
          menu = "on-click";
          menu-file = ./powermenu.xml;
          menu-actions = {
            lock = "${loginctl} lock-session";
            sleep = "${systemctl} sleep";
            poweroff = "${systemctl} poweroff";
            reboot = "${systemctl} reboot";
            reboot-uefi = "${systemctl} reboot --firmware-setup";
          };
        };
        memory = {
          interval = 10;
          format = "{used:4.1f}G<small> </small>{icon}";
          format-icons = [""];
        };
        cpu = {
          interval = 10;
          format = "{usage:3}%<small> </small>{icon}";
          format-icons = [""];
        };
        temperature = {
          interval = 10;
          hwmon-path = "/sys/class/hwmon/hwmon5/temp1_input";
          format = "{temperatureC:2}°C<small> </small>{icon}";
          format-icons = ["󰏈"];
        };
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
          format = "{capacity:3}%<small> </small>{icon}";
          format-charging = "{capacity:3}%<small> </small>󰢝";
          format-plugged = "{capacity:3}%<small> </small>󰚥";
          onclick = "";
        };

        # ------------------------------- Center -------------------------------
        "hyprland/workspaces" = {
          on-click = "activate";
          on-scroll-up = "${hyprctl} dispatch workspace e+1";
          on-scroll-down = "${hyprctl} dispatch workspace e-1";
          show-special = false;
          persistent-workspaces."*" = 5;
          format = "{icon}";
          format-icons = {
            empty = "";
            default = "󰊠";
            active = "󰮯";
            urgent = "";
          };
        };

        # ------------------------------- Right -------------------------------
        tray = {
          icon-size = 16;
          spacing = 4;
        };
        bluetooth = {
          on-click = "overskride";
          on-click-right = "rfkill toggle bluetooth";
          format = "";
          format-connected = "󰂱";
          format-disabled = "󰂲";
          format-off = "󰂲";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-disabled = "";
          tooltip-format-off = "";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        network = {
          on-click-right = "rfkill toggle wlan";
          interval = 5;
          format-ethernet = "<small>{ifname}</small> 󰈀";
          format-wifi = "<small>{essid}</small> 󰖩";
          format-disconnected = "󰌙";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            tx: {bandwidthUpOctets}
            rx: {bandwidthDownOctets}'';
        };
        pulseaudio = {
          on-click = "pavucontrol";
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon}󰂯 {format_source}";
          format-muted = "0% 󰝟 {format_source}";
          format-source = "{volume}% 󰍬";
          format-source-muted = "0% 󰍭";
          format-icons = {
            default = ["" ""];
            headphone = "󰋋";
          };
        };
        "group/applets" = {
          orientation = "inherit";
          modules = [
            "bluetooth"
            "idle_inhibitor"
            "network"
            "pulseaudio"
          ];
        };
        clock = {
          interval = 1;
          format = "{:%H:%M:%S}";
          on-click-left = "mode";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 2;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>S{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
      };
    };

    style = lib.mkAfter (builtins.readFile ./style.css);
  };
}
