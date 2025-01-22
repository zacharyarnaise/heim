{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 3;
      };

      background = {
        blur_passes = 4;
        blur_size = 8;
        contrast = 1.0;
        brightness = 0.8;
        vibrancy_darkness = 0.8;
      };

      input-field = {
        size = "400, 70";
        position = "0, 0";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_center = true;
        fade_on_empty = true;
        fade_timeout = 3000;
        placeholder_text = "sup?";
        shadow_passes = 2;
        shadow_size = 2;
      };
    };
  };
}
