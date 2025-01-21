{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 3;
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutCirc,   0,     0.55, 0.45,  1"
          "easeInSine,    0.12,  0,    0.39,  0"
          "easeInOutQuad, 0.45,  0,    0.55,  1"
        ];
        animation = [
          "fadeIn,   1, 10, easeOutCirc"
          "fadeOut,  1, 4, easeInSine"

          "inputFieldFade, 1, 5, easeInOutQuad"
        ];
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
