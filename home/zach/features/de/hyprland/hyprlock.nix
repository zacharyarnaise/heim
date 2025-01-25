{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
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
