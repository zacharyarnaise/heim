{
  config,
  lib,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.finalPackage}/bin/hyprctl";
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "uwsm finalize"
      "${hyprctl} setcursor ${config.stylix.cursor.name} ${toString config.stylix.cursor.size}"
      "${hyprctl} dispatch workspace 1" # Focus the first workspace on startup
    ];

    general = {
      layout = "dwindle";
      border_size = 2;
      gaps_in = 10;
      gaps_out = 15;
      resize_on_border = true;
      extend_border_grab_area = 20;
    };

    xwayland = {
      enabled = false;
      use_nearest_neighbor = true;
      force_zero_scaling = true;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
      force_split = 2;
      split_width_multiplier = 1.5;
    };

    layerrule = [
      "animation slide, notifications"

      "animation slide, rofi"
      "order -10, rofi" # pinentry uses rofi and needs to be on top

      "animation fade, waybar"
      "blur, waybar"
      "ignorezero, waybar"

      "noanim, hyprpaper"
      "noanim, overview"
      "noanim, selection"
    ];
    windowrule = [
      "float, class:(clipse)"
      "animation slide, class:(clipse)"
      "noborder, class:(clipse)"
      "size 600 400, class:(clipse)"
      "move 38% 45, class:(clipse)"
      "pin, class:(clipse)"
      "stayfocused, class:(clipse)"
      "noscreenshare, class:(clipse)"

      "nomaxsize, class:(org.wezfurlong.wezterm)"

      "float, class:(io.github.Qalculate.qalculate-qt)"
      "size 640 500, class:(io.github.Qalculate.qalculate-qt)"
      "pin, class:(io.github.Qalculate.qalculate-qt)"
      "opacity 1.0 override, class:(io.github.Qalculate.qalculate-qt)"

      "opacity 1.0 override, initialTitle:(Discord Popout)"
      "workspace 7, initialTitle:(Discord Popout)"

      "opacity 1.0 override 0.95 override, class:^(chromium-browser|firefox|feishin)$"

      # make pop-up file dialogs floating, centred, and pinned
      "float, title:(Open|Progress|Save File)"
      "center, title:(Open|Progress|Save File)"
      "pin, title:(Open|Progress|Save File)"
      "float, class:(xdg-desktop-portal-gtk)"
      "center, class:(xdg-desktop-portal-gtk)"
      "pin, class:(xdg-desktop-portal-gtk)"
    ];

    decoration = {
      rounding = 8;
      rounding_power = 4.0;
      dim_inactive = true;
      dim_strength = 0.1;
      active_opacity = config.stylix.opacity.applications;
      inactive_opacity = config.stylix.opacity.applications;
      fullscreen_opacity = 1.0;

      blur = {
        enabled = true;
        popups = true;
        size = 5;
        passes = 2;
        contrast = 0.75;
        brightness = 0.9;
        vibrancy = 0.3;
        vibrancy_darkness = 0.2;
        xray = true;
      };

      shadow = {
        enabled = true;
        range = 16;
        render_power = 4;
        offset = "0 0";
        scale = 0.98;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "easeInQuad,  0.11, 0,   0.5,   0.6"
        "easeInBack,  0.36, 0,   0.65, -0.6"

        "easeOutQuad, 0.5,  1,   0.89,  1"
        "easeOutBack, 0.4,  1.5, 0.65,  1"

        "easeInOutQuad, 0.45, 0, 0.55, 1"
      ];
      animation = [
        "windowsIn,   1, 3, easeOutBack, popin 20%"
        "windowsOut,  1, 3, easeInBack,  popin 60%"
        "windowsMove, 1, 4, easeOutBack, slide 50%"

        "layersIn,  1, 2, easeOutBack, fade"
        "layersOut, 1, 3, easeInBack,  fade"

        "fadeIn,        1, 2, easeOutQuad"
        "fadeOut,       1, 2, easeInQuad"
        "fadeSwitch,    1, 1, easeInOutQuad"
        "fadeShadow,    1, 3, easeInOutQuad"
        "fadeDim,       1, 2, easeInOutQuad"
        "fadeLayersIn,  1, 3, easeOutBack"
        "fadeLayersOut, 1, 3, easeInBack"
        "fadePopups,    0"
        "fadeDpms,      1, 20, easeInOutQuad"

        "border, 1, 5, easeOutQuad"

        "workspaces,       1, 3, easeOutBack, slidefade 10%"
        "specialWorkspace, 1, 3, easeOutBack, slidefadevert 10%"
      ];
    };

    input = {
      kb_model = config.hostSpec.kbdModel;
      kb_layout = config.hostSpec.kbdLayout;
      kb_variant = config.hostSpec.kbdVariant;
      numlock_by_default = true;
      repeat_rate = 30;
      repeat_delay = 400;

      accel_profile = "flat";
      sensitivity = 0.1;
      follow_mouse = 1;
      mouse_refocus = true;

      scroll_method = "2fg";
      touchpad = {
        disable_while_typing = true;
        middle_button_emulation = true;
      };
    };

    gesture = [
      "3, horizontal, workspace"
      "4, left, dispatcher, movewindow, mon:-1"
      "4, right, dispatcher, movewindow, mon:+1"
    ];

    cursor = {
      enable_hyprcursor = true;
      inactive_timeout = 5.0;
      hide_on_key_press = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      vfr = true;
      vrr = 1;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      disable_autoreload = true;
      new_window_takes_over_fullscreen = 2;
    };

    monitor =
      map (
        m: "${m.name},${
          if m.enabled
          then
            "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position},${m.scale}"
            + (
              if m.extraArgs != null
              then ",${m.extraArgs}"
              else ""
            )
          else "disable"
        }"
      )
      config.monitors;

    # Bind workspaces to their respective monitors. Also, the first declared
    # workspace on each monitor is set as default + persistent.
    workspace = builtins.concatLists (map (m:
      lib.lists.imap0 (
        i: workspace:
          "${workspace},monitor:${m.name}"
          + (
            if i == 0
            then ",default:true"
            else ""
          )
      )
      m.workspaces)
    config.monitors);

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };
  };
}
