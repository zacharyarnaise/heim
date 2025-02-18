{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        ignore_empty_input = true;
        # https://github.com/hyprwm/hyprlock/issues/494
        hide_cursor = false;
        grace = 3;
      };

      background = {
        monitor = "";
        blur_passes = 2;
        blur_size = 4;
        noise = 0.02;
        contrast = 1.0;
        brightness = 0.8;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };

      input-field = {
        size = "400, 48";
        position = "0, 0";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_center = true;
        fade_on_empty = true;
        fade_timeout = 3000;
        placeholder_text = "( ͡° ͜ʖ ͡°)";
        shadow_passes = 2;
        shadow_size = 2;
      };
    };
  };
}
