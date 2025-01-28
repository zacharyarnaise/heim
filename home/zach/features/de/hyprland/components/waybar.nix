{
  lib,
  config,
  ...
}: {
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
          "clock"
        ];
        modules-right = [
        ];

        "clock" = {
          interval = 1;
          format = "{:L%H:%M:%S}";
          on-click-left = "mode";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 0;
            "format" = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffdd'><b>S{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
      };
    };

    style = lib.mkAfter ''
      * {
        padding: 0;
        margin: 0 0.4em;
      }
      window#waybar, tooltip {
        border-radius: 0.5em;
      }
      .modules-left {
        margin-left: -0.65em;
      }
      .modules-right {
        margin-right: -0.65em;
      }

      window#waybar {
        border: 0.1em solid alpha(@base0D, 0.5);
      }
      #clock {
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 0.6em;
        background-color: alpha(@base0D, 0.9);
      }

      #clock {
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 11pt;
        font-weight: 600;
        padding-right: 0.9em;
        padding-left: 0.9em;
      }
    '';
  };
}
