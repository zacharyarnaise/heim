{
  wayland.windowManager.hyprland.settings.layer_rule = [
    {
      match = {
        namespace = "overview|selection";
      };
      no_anim = true;
    }

    # ---- Noctalia ----
    {
      match = {
        namespace = "noctalia-.*";
      };
      blur = true;
      ignore_alpha = 0.1;
      no_anim = true;
    }
    {
      match = {
        namespace = "noctalia-notification|noctalia-osd";
      };
      animation = "slide right";
      order = 10;
      no_anim = false;
    }
    {
      match = {
        namespace = "noctalia-panel";
      };
      animation = "fade";
      dim_around = true;
      no_anim = false;
      order = 10;
      xray = false;
    }
  ];
}
