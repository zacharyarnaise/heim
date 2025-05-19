{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        ignore_empty_input = true;
        hide_cursor = true;
        grace = 0;
      };

      background = {
        monitor = "";
        blur_passes = 2;
        blur_size = 6;
        noise = 0.02;
        contrast = 0.9;
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
