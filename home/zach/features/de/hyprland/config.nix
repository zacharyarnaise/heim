{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    config = {
      animations = {
        enabled = true;
        workspace_wraparound = true;
      };

      binds = {
        movefocus_cycles_fullscreen = false;
      };

      cursor = {
        default_monitor = config.primaryMonitor.name;
        enable_hyprcursor = true;
        hide_on_key_press = true;
        inactive_timeout = 5.0;
      };

      decoration = {
        active_opacity = config.stylix.opacity.applications;
        dim_around = 0.6;
        dim_inactive = false;
        dim_strength = 0.2;
        fullscreen_opacity = 1.0;
        inactive_opacity = 0.75;
        rounding = 10;
        rounding_power = 3.0;

        blur = {
          enabled = true;
          brightness = 0.75;
          contrast = 1.0;
          noise = 0.06;
          passes = 2;
          popups = true;
          popups_ignorealpha = 0.25;
          size = 5;
          vibrancy = 0.15;
          vibrancy_darkness = 0.4;
          xray = true;
        };

        glow = {
          enabled = true;
          range = 12;
          render_power = 4;
        };

        shadow.enabled = false;
      };

      dwindle = {
        force_split = 2;
        preserve_split = true;
        split_width_multiplier = 1.3;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      general = {
        border_size = 2;
        gaps_in = 4;
        gaps_out = 8;
        layout = "dwindle";
        resize_on_border = true;
      };

      gesture = [
        {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        }
        {
          fingers = 4;
          direction = "left";
          action = "dispatcher, movewindow, mon:-1";
        }
        {
          fingers = 4;
          direction = "right";
          action = "dispatcher, movewindow, mon:+1";
        }
      ];

      gestures = {
        workspace_swipe_forever = true;
      };

      input = {
        kb_model = config.hostSpec.kbdModel;
        kb_layout = config.hostSpec.kbdLayout;
        kb_variant = config.hostSpec.kbdVariant;
        numlock_by_default = true;
        repeat_rate = 50;
        repeat_delay = 400;

        accel_profile = "flat";
        follow_mouse = 1;
        follow_mouse_threshold = 200.0;
        mouse_refocus = true;
        sensitivity = 0.1;

        scroll_method = "2fg";
        touchpad = {
          disable_while_typing = true;
          middle_button_emulation = true;
        };
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
        on_focus_under_fullscreen = 2;
        vrr = 1;
      };

      render = {
        direct_scanout = 1;
      };

      xwayland = {
        enabled = false;
        force_zero_scaling = true;
      };
    };

    monitor =
      map (
        m:
          if m.enabled
          then {
            output = m.name;
            mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            cm = "auto";
            inherit (m) position scale transform;
          }
          else {
            output = m.name;
            disabled = true;
          }
      )
      config.monitors;
  };
}
