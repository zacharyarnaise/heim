{
  config,
  pkgs,
  ...
}: let
  mod = "SUPER";
  modShift = "SUPER_SHIFT";

  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  handlr = type: "${pkgs.handlr-regex}/bin/handlr launch ${type}";
in {
  wayland.windowManager.hyprland.settings = {
    binds = {
      movefocus_cycles_fullscreen = false;
    };

    bindd = [
      # General
      "${modShift}, End, Terminate session, exit"
      "${modShift}, Backspace, Reload configuration, exec, ${hyprctl} reload"
      "${modShift}, L, Lock session, exec, ${loginctl} lock-session"

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

      # Programs
      "${mod},      Alt, Opens rofi, exec, rofi --show drun"
      "${mod},      Space, Opens terminal, exec, ${handlr "x-scheme-handler/terminal"}"
    ];
  };
}
