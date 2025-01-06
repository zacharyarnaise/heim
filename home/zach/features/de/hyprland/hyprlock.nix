{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 4;
          blur_size = 8;
          vibrancy_darkness = 0.04;
        }
      ];

      input-field = [
        {
          size = "400, 80";
          position = "0, 0";
          dots_center = true;
          fade_on_empty = true;
          outline_thickness = 3;
          placeholder_text = "sup?";
          shadow_passes = 2;
          shadow_size = 4;
        }
      ];
    };
  };
}
