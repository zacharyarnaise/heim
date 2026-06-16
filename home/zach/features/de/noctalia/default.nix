{
  inputs,
  config,
  ...
}: let
  wallsDir = "${config.home.homeDirectory}/Pictures/Walls";
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home = {
    file.".local/state/noctalia/.setup-complete".text = "";
  };

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar.widgets = {
        background_opacity = 0.25;
        border = "primary";
        capsule_opacity = 0.5;
        capsule_thickness = 0.75;
        center = ["taskbar"];
        enabled = false;
        end = ["group:g4" "spacer_1" "group:g2" "spacer_2" "date"];
        font_family = "Inter Display";
        font_weight = 400;
        margin_edge = 0;
        margin_ends = 6;
        padding = 10;
        panel_overlap = 2;
        radius = 0;
        radius_bottom_left = 30;
        radius_bottom_right = 30;
        shadow = false;
        start = ["launcher" "spacer_1" "group:g1" "spacer_1" "group:g3"];
        thickness = 36;
        monitor.${config.primaryMonitor.name}.enabled = true;
        capsule_group = [
          {
            fill = "surface_variant";
            id = "g1";
            members = ["cpu" "temp" "ram"];
            opacity = 0.25;
            padding = 8.0;
          }
          {
            fill = "surface_variant";
            id = "g3";
            members = ["media" "audio_visualizer"];
            opacity = 0.25;
            padding = 6.0;
          }
          {
            fill = "surface_variant";
            id = "g4";
            members = ["tray" "notifications" "nightlight" "caffeine"];
            opacity = 0.25;
            padding = 8.0;
          }
          {
            fill = "surface_variant";
            id = "g2";
            members = ["output_volume" "input_volume" "brightness" "battery"];
            opacity = 0.25;
            padding = 8.0;
          }
        ];
      };

      brightness.enable_ddcutil = true;

      control_center.shortcuts = [
        {type = "wifi";}
        {type = "bluetooth";}
        {type = "caffeine";}
        {type = "nightlight";}
        {type = "notification";}
      ];

      desktop_widgets.enabled = false;

      dock.enabled = false;

      idle = {
        behavior_order = ["lock" "screen-off" "lock-and-suspend"];
        pre_action_fade_seconds = 10;
        behavior = {
          lock = {
            action = "lock";
            enabled = true;
            timeout = 600;
          };
          "lock-and-suspend" = {
            action = "lock_and_suspend";
            enabled = false;
            timeout = 900;
          };
          "screen-off" = {
            action = "screen_off";
            enabled = true;
            timeout = 660;
          };
        };
      };

      location.address = inputs.secrets.users.zach.noctalia.location;

      lockscreen = {
        fingerprint = false;
        monitors = [config.primaryMonitor.name];
      };

      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@${config.primaryMonitor.name}"
          "lockscreen-login-box@DP-2"
        ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "lockscreen-login-box@DP-2" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 720.0;
            cy = 2437.0;
            output = "DP-2";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_login_button = true;
            };
          };
          "lockscreen-login-box@${config.primaryMonitor.name}" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 1280.0;
            cy = 1317.0;
            output = config.primaryMonitor.name;
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_login_button = true;
            };
          };
          "lockscreen-widget-0000000000000001" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 1280.0;
            cy = 125.87890625;
            output = config.primaryMonitor.name;
            rotation = 0.0;
            type = "clock";
            settings = {
              background = true;
              background_color = "primary";
              background_opacity = 0.2;
              background_padding = 10.0;
              background_radius = 30.0;
              clock_style = "digital";
              font_family = "";
              format = "{:%H:%M:%S}";
            };
          };
        };
      };

      nightlight = {
        enabled = true;
        temperature_night = 3500;
      };

      notification = {
        background_opacity = 0.5;
        monitors = [config.primaryMonitor.name];
        offset_x = 4;
        offset_y = 4;
        show_app_name = false;
      };

      osd = {
        background_opacity = 0.5;
        monitors = [config.primaryMonitor.name];
        offset_x = 4;
        offset_y = 4;
        position = "top_right";
        scale = 0.9;
        kinds = {
          keyboard_layout = false;
          lock_keys = false;
        };
      };

      shell = {
        font_family = "Inter Display";
        lang = "en";
        password_style = "random";
        polkit_agent = true;
        settings_show_advanced = true;
        show_location = false;
        animation.speed = 1.0;
        mpris.blacklist = ["firefox"];
        panel = {
          clipboard_placement = "attached";
          launcher_placement = "attached";
          open_near_click_clipboard = true;
          open_near_click_control_center = true;
          open_near_click_launcher = true;
          session_placement = "centered";
          transparency_mode = "glass";
        };
        screenshot.save_to_file = false;
        shadow.alpha = 0.5;
      };

      system.monitor = {
        cpu_temp_activity_threshold = 80;
        cpu_temp_critical_threshold = 95;
        disk_poll_seconds = 30;
      };

      theme = {
        source = "community";
        mode = "dark";
        community_palette = "Ayu Blue";
        templates = {
          enable_builtin_templates = false;
          enable_community_templates = false;
        };
      };

      wallpaper = {
        directory = wallsDir;
        edge_smoothness = 0.5;
        enabled = true;
        transition = ["wipe"];
        transition_duration = 1000;
        transition_on_startup = true;
        default.path = "${wallsDir}/wallhaven-x6128o.jpg";
        last.path = "${wallsDir}/wallhaven-x6128o.jpg";
      };

      widget = {
        audio_visualizer = {
          bands = 32;
          centered = false;
          color_2 = "on_surface";
          mirrored = false;
          width = 100.0;
        };
        battery.font_family = "Iosevka";
        brightness.font_family = "Iosevka";
        cpu.font_family = "Iosevka";
        date = {
          font_family = "Noto Sans CJK HK";
          font_weight = 400;
          format = "{:%H:%M:%S} - {:%a %d %b}";
        };
        input_volume.font_family = "Iosevka";
        output_volume.font_family = "Iosevka";
        launcher = {
          capsule = true;
          capsule_opacity = 0.25;
          capsule_padding = 8.0;
          glyph = "rocket";
          scale = 1.3;
        };
        media = {
          font_family = "Noto Sans CJK HK";
          hide_when_no_media = true;
          max_length = 320;
          min_length = 150;
          title_scroll = "on_hover";
        };
        ram = {
          display = "text";
          font_family = "Iosevka";
          show_label = false;
        };
        spacer_1 = {
          length = 10;
          type = "spacer";
        };
        spacer_2 = {
          capsule_padding = 23.0;
          capsule_radius = 11;
          length = 25;
          type = "spacer";
        };
        spacer_3 = {
          length = 14;
          type = "spacer";
        };
        taskbar = {
          empty_color = "tertiary";
          font_family = "Iosevka Heavy";
          group_by_workspace = true;
          group_single_icon_per_app = true;
          inactive_opacity = 0.75;
          scale = 1.2;
          show_active_indicator = false;
        };
        temp = {
          display = "text";
          font_family = "Iosevka";
          show_label = false;
        };
        tray.drawer = true;
        workspaces.font_family = "Iosevka Medium";
      };
    };
  };
}
