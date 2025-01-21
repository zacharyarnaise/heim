{
  wayland.windowManager.hyprland.settings = {
    binds = {
      movefocus_cycles_fullscreen = false;
    };

    "$mod" = "SUPER";

    bind = [
      # Focus
      "$mod, LEFT, movefocus, l"
      "$mod, RIGHT, movefocus, r"
      "$mod, UP, movefocus, u"
      "$mod, DOWN, movefocus, d"
    ];
  };
}
