let
  mod = "SUPER";
  modShift = "SUPER_SHIFT";
in {
  wayland.windowManager.hyprland.settings = {
    binds = {
      movefocus_cycles_fullscreen = false;
    };

    bindd = [
      # General
      "${modShift}, Delete, Terminate session, exec, pkill Hyprland"

      # Window control
      "${mod},      W, Closes the active window, killactive"
      "${mod},      S, Toggle maximize, fullscreen, 1"
      "${modShift}, S, Toggle fullscreen, fullscreen, 0"
      "${mod},      F, Toggle floating, togglefloating,"

      # Movement
      "${mod},      LEFT, Moves focus left, movefocus, l"
      "${mod},      RIGHT, Moves focus right, movefocus, r"
      "${mod},      UP, Moves focus up, movefocus, u"
      "${mod},      DOWN, Moves focus down, movefocus, d"
      "${modShift}, LEFT, Moves the active window left, movewindow, l"
      "${modShift}, RIGHT, Moves the active window right, movewindow, r"
      "${modShift}, UP, Moves the active window up, movewindow, u"
      "${modShift}, DOWN, Moves the active window down, movewindow, d"
    ];
  };
}
