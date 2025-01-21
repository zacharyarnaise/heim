{pkgs, ...}: let
  mod = "SUPER";
  modShift = "SUPER_SHIFT";

  loginctl = "${pkgs.systemd}/bin/loginctl";
in {
  wayland.windowManager.hyprland.settings = {
    binds = {
      movefocus_cycles_fullscreen = false;
    };

    bind = [
      # General
      "${modShift}, Delete, Terminate session, exec, ${loginctl} terminate-session \"$XDG_SESSION_ID\""

      # Window control
      "${mod},      W, Closes the active window, killactive"
      "${mod},      S, Toggle maximize, fullscreen, 1"
      "${modShift}, S, Toggle fullscreen, fullscreen, 0"
      "${mod},      F, Toggle floating, togglefloating,"

      # Movement
      "${mod},      LEFT, movefocus, l"
      "${mod},      RIGHT, movefocus, r"
      "${mod},      UP, movefocus, u"
      "${mod},      DOWN, movefocus, d"
      "${modShift}, LEFT, movewindow, l"
      "${modShift}, RIGHT, movewindow, r"
      "${modShift}, UP, movewindow, u"
      "${modShift}, DOWN, movewindow, d"
    ];
  };
}
