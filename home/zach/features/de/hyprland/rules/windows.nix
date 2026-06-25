{config, ...}: {
  wayland.windowManager.hyprland.settings.window_rule = [
    # ---------------------------------- TAGS ----------------------------------
    {
      match = {
        class = "chromium-browser|firefox";
      };
      tag = "browser";
    }
    {
      match = {
        class = "xdg-desktop-portal-gtk";
      };
      tag = "popup";
    }
    {
      match = {
        initial_title = "Open|Progress|Save As|Save File";
      };
      tag = "popup";
    }
    {
      match = {
        float = false;
        workspace = "f[1]";
      };
      tag = "smartgaps";
    }
    {
      match = {
        float = false;
        workspace = "w[tv1]";
      };
      tag = "smartgaps";
    }

    # ------------------------------- Fullscreen -------------------------------
    {
      match = {
        fullscreen = true;
      };
      no_dim = true;
      opaque = true;
    }

    # --------------------------------- Popups ---------------------------------
    {
      match = {
        tag = "popup";
      };
      center = true;
      float = true;
      size = ["monitor_w * 0.3" "monitor_h * 0.3"];
    }

    # ------------------------------- Smart gaps -------------------------------
    {
      match = {
        tag = "smartgaps";
      };
      border_size = 1;
    }
    {
      match = {
        tag = "smartgaps";
      };
      opacity = "${toString config.stylix.opacity.applications} override";
    }

    # --------------------------- Special workspace ---------------------------
    {
      match = {
        workspace = "special:scratchpad";
      };
      border_size = 0;
      float = true;
      max_size = ["monitor_w" "monitor_h * 0.9"];
      move = ["monitor_w * 0.005" "monitor_h * 0.03"];
      no_anim = true;
      no_dim = true;
      opacity = "0.75 override";
      size = ["monitor_w * 0.99" "monitor_h * 0.4"];
    }

    # -------------------------------- Browsers --------------------------------
    {
      match = {
        tag = "browser";
      };
      opacity = "1.0 override 0.95 override";
    }

    # -------------------------------- Discord --------------------------------
    # TODO: detect if workspace 8 is available (e.g. external screen)
    {
      match = {
        class = "vesktop";
        initial_title = "Discord Popout";
      };
      fullscreen = true;
      idle_inhibit = "always";
      no_dim = true;
      opaque = true;
      workspace = "7";
    }
    {
      match = {
        class = "vesktop";
        initial_title = "Discord";
        modal = false;
      };
      fullscreen = true;
      no_dim = true;
      no_initial_focus = true;
      opaque = true;
      workspace = "8";
    }

    # -------------------------------- Feishin --------------------------------
    # TODO: detect if workspace 9 is available (e.g. external screen)
    {
      match = {
        class = "feishin";
      };
      fullscreen = true;
      opacity = "0.95 override";
      workspace = "9";
    }

    # -------------------------------- Nautilus --------------------------------
    {
      match = {
        class = "org.gnome.Nautilus";
      };
      float = true;
      opacity = "0.9 override";
      size = ["monitor_w * 0.5" "monitor_h * 0.5"];
    }

    # -------------------------------- Noctalia --------------------------------
    {
      match = {
        class = "dev.noctalia.Noctalia.Settings";
      };
      center = true;
      float = true;
      size = ["monitor_w * 0.5" "monitor_h * 0.5"];
    }

    # ------------------------------- Qalculate! -------------------------------
    {
      match = {
        class = "io.github.Qalculate.qalculate-qt";
      };
      float = true;
      opacity = "0.9 override";
      pin = true;
      render_unfocused = true;
      size = ["monitor_w * 0.2" "monitor_h * 0.3"];
    }
  ];
}
