{
  config,
  pkgs,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  handlr = type: "${pkgs.handlr-regex}/bin/handlr launch ${type}";

  mod = "SUPER";
  modAlt = "SUPER_ALT";
  modCtrl = "SUPER_CONTROL";
  modShift = "SUPER_SHIFT";

  workspaces = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "0"];
in {
  wayland.windowManager.hyprland.settings = {
    binds = {
      movefocus_cycles_fullscreen = false;
    };

    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];

    bindd =
      [
        # General
        "${modShift}, End, Terminate session, exit"
        "${modShift}, Backspace, Reload configuration, exec, ${hyprctl} reload"
        "${modShift}, L, Lock session, exec, ${loginctl} lock-session"

        # Window control
        "${mod},      W, Closes the active window, killactive"
        "${mod},      S, Toggle maximize, fullscreen, 1"
        "${modShift}, S, Toggle fullscreen, fullscreen, 0"
        "${mod},      F, Toggle floating, togglefloating,"

        # Window movement
        "${mod},      LEFT, Moves focus left, movefocus, l"
        "${mod},      RIGHT, Moves focus right, movefocus, r"
        "${mod},      UP, Moves focus up, movefocus, u"
        "${mod},      DOWN, Moves focus down, movefocus, d"
        "${modCtrl}, LEFT, Swaps the active window left, swapwindow, l"
        "${modCtrl}, RIGHT, Swaps the active window right, swapwindow, r"
        "${modCtrl}, UP, Swaps the active window up, swapwindow, u"
        "${modCtrl}, DOWN, Swaps the active window down, swapwindow, d"
        "${modShift}, LEFT, Moves the active window left, movewindow, l"
        "${modShift}, RIGHT, Moves the active window right, movewindow, r"
        "${modShift}, UP, Moves the active window up, movewindow, u"
        "${modShift}, DOWN, Moves the active window down, movewindow, d"

        # Monitor focus
        "${modAlt}, LEFT, Moves focus to the left monitor, focusmonitor, l"
        "${modAlt}, RIGHT, Moves focus to the right monitor, focusmonitor, r"
        "${modAlt}, UP, Moves focus to the upper monitor, focusmonitor, u"
        "${modAlt}, DOWN, Moves focus to the lower monitor, focusmonitor, d"

        # Programs
        "${mod},      Space, Opens rofi, exec, rofi --show drun"
        "${mod},      Return, Opens terminal, exec, ${handlr "x-scheme-handler/terminal"}"
      ]
      ++ (map (n: "${mod}, ${n}, Changes to workspace ${n}, workspace, name:${n}") workspaces)
      ++ (map (n: "${modShift}, ${n}, Moves active window to workspace ${n}, movetoworkspacesilent, name:${n}") workspaces);
  };
}
