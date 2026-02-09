{
  config,
  lib,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.finalPackage}/bin/hyprctl";
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${hyprctl} setcursor ${config.stylix.cursor.name} ${toString config.stylix.cursor.size}"
      "${hyprctl} dispatch workspace 1" # Focus the first workspace on startup
    ];

    general = {
      layout = "dwindle";
      border_size = 2;
      gaps_in = 5;
      gaps_out = 10;
      resize_on_border = false;
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

    layerrule = let
      mkDecorationRules = ns: ignoreAlpha:
        "match:namespace ${ns}, "
        + lib.concatStringsSep ", " [
          "blur true"
          "ignore_alpha ${toString ignoreAlpha}"
        ];
    in
      [
        "match:namespace hyprpaper, no_anim true"
        "match:namespace hyprpicker, no_anim true"
        "match:namespace overview, no_anim true"
        "match:namespace selection, no_anim true"

        "match:namespace notifications, animation slide"
        "match:namespace notifications, order 10"

        "match:namespace rofi, animation slide"
        "match:namespace rofi, order 0"

        "match:namespace main-bar, animation fade"
      ]
      ++ [
        (mkDecorationRules "notifications" 0.5)
        (mkDecorationRules "rofi" 0.5)
        (mkDecorationRules "main-bar" 0.25)
      ];
    windowrule = [
      "match:fullscreen 1, no_dim true"

      "match:class clipse, animation slide"
      "match:class clipse, border_size 0"
      "match:class clipse, float true"
      "match:class clipse, pin true"
      "match:class clipse, size 600 400"
      "match:class clipse, move (monitor_w-window_w)*0.5 45"
      "match:class clipse, no_screen_share true"
      "match:class clipse, stay_focused true"

      "match:class .*qalculate-qt$, float true"
      "match:class .*qalculate-qt$, pin true"
      "match:class .*qalculate-qt$, size 640 500"
      "match:class .*qalculate-qt$, opacity 1.0"

      "match:class io.github.Qalculate.qalculate-qt, size 640 500"
      "match:class io.github.Qalculate.qalculate-qt, opacity 1.0"

      "match:initial_title Discord Popout, opacity 1.0 override"
      "match:initial_title Discord Popout, workspace 7"

      "match:class ^(chromium-browser|firefox|feishin)$, opacity 1.0 override 0.95 override"

      "match:class xdg-desktop-portal-gtk, float true"
      "match:class xdg-desktop-portal-gtk, pin true"
      "match:class xdg-desktop-portal-gtk, center true"
      "match:title (Open|Progress|Save File), float true"
      "match:title (Open|Progress|Save File), pin true"
      "match:title (Open|Progress|Save File), center true"
    ];

    decoration = let
      baseOpacity = config.stylix.opacity.applications;
    in {
      rounding = 10;
      rounding_power = 4.0;
      dim_inactive = true;
      dim_strength = 0.15;
      active_opacity = baseOpacity;
      inactive_opacity = baseOpacity * 0.95;
      fullscreen_opacity = 1.0;

      blur = {
        enabled = true;
        popups = false;
        size = 5;
        passes = 2;
        noise = 0.05;
        contrast = 1.1;
        brightness = 0.8;
        vibrancy = 0.2;
        vibrancy_darkness = 0.1;
        xray = true;
      };

      shadow = {
        enabled = false;
        range = 4;
        render_power = 1;
        offset = "0 0";
        scale = 1.0;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "easeInOutQuad, 0.45, 0, 0.55, 1"
        "easeOutBack, 0.4, 1.5, 0.65, 1"
        "easeOutExpo, 0.16, 1, 0.3, 1"
        "easeOutQuad, 0.5, 1, 0.89, 1"
      ];
      animation = [
        "windowsIn,   1, 4, easeOutExpo, popin 20%"
        "windowsOut,  1, 4, easeOutExpo, popin"
        "windowsMove, 1, 2, easeInOutQuad"

        "layersIn,  1, 1, easeOutQuad, popin"
        "layersOut, 1, 3, easeOutExpo, fade"

        "fadeIn,        1, 5, easeOutExpo"
        "fadeOut,       1, 3, easeOutExpo"
        "fadeSwitch,    1, 3, easeOutExpo"
        "fadeShadow,    1, 4, easeOutExpo"
        "fadeDim,       1, 4, easeOutExpo"
        "fadeSwitch,    1, 3, easeOutExpo"
        "fadeLayersIn,  1, 3, easeOutExpo"
        "fadeLayersOut, 1, 3, easeOutExpo"
        "fadePopups,    0"
        "fadeDpms,      1, 10, easeOutQuad"

        "border,      1, 5, easeOutQuad"
        "borderangle, 1, 10, easeOutExpo, once"

        "workspaces,       1, 3, easeOutBack, slidefade 10%"
        "specialWorkspace, 1, 3, easeOutBack, slidefadevert 10%"

        "zoomFactor,   1, 3, easeOutExpo"
        "monitorAdded, 0"
      ];
    };

    input = {
      kb_model = config.hostSpec.kbdModel;
      kb_layout = config.hostSpec.kbdLayout;
      kb_variant = config.hostSpec.kbdVariant;
      numlock_by_default = true;
      repeat_rate = 50;
      repeat_delay = 400;

      accel_profile = "flat";
      sensitivity = 0.1;
      follow_mouse = 1;
      follow_mouse_threshold = 200.0;
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
      vrr = 3;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      disable_autoreload = true;
      on_focus_under_fullscreen = 2;
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
