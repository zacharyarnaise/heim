{lib, ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin-bottom = 0;
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
          "format" = "{:L%H:%M}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
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
          "actions" = {
            "on-click-right" = "mode";
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
        broder-radius: 0.5em;
      }
      .modules-left {
        margin-left: -0.6em;
      }
      .modules-right {
        margin-right: -0.6em;
      }
    '';
  };
}
