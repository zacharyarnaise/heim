{config, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    extraConfig = ''
      return {
        font_size = 18.0,

        animation_fps = 60,
        audible_bell = "Disabled",
        automatically_reload_config = true,
        check_for_updates = false,
        default_cursor_style = "BlinkingBlock",
        cursor_blink_ease_in = "Constant",
        cursor_blink_ease_out = "Linear",
        cursor_blink_rate = 500,
        enable_scroll_bar = false,
        enable_wayland = false,
        freetype_load_target = "Normal",
        front_end = "WebGpu",
        hide_mouse_cursor_when_typing = true,
        hide_tab_bar_if_only_one_tab = true,
        scrollback_lines = 10000,
        skip_close_confirmation_for_processes_named = {
          "zsh",
        },
        visual_bell = {
          fade_in_function = "EaseIn",
          fade_in_duration_ms = 100,
          fade_out_function = "EaseOut",
          fade_out_duration_ms = 200,
          target = "CursorColor",
        },
        webgpu_power_preference = "HighPerformance",
        window_decorations = "RESIZE",
        window_padding = {
          left = "1cell",
          right = 0,
          top = "0.25cell",
          bottom = 0,
        },
      }
    '';
  };
}
