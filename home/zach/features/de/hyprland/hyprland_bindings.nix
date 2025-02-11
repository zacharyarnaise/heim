{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  fuzzel = "${config.programs.fuzzel.package}/bin/fuzzel";
  cliphist = "${config.services.cliphist.package}/bin/cliphist";
  handlr = type: "${pkgs.handlr-regex}/bin/handlr launch ${type}";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";

  mod = "SUPER";
  modAlt = "SUPER_ALT";
  modCtrl = "SUPER_CONTROL";
  modShift = "SUPER_SHIFT";

  workspaces = {
    "1" = "ampersand";
    "2" = "eacute";
    "3" = "quotedbl";
    "4" = "apostrophe";
    "5" = "parenleft";
    "6" = "minus";
    "7" = "egrave";
    "8" = "underscore";
    "9" = "ccedilla";
    "10" = "agrave";
  };
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
        "${mod},      P, Toggle pseudotile, pseudo"

        # Window movement
        "${mod}, LEFT, Moves focus left, movefocus, l"
        "${mod}, RIGHT, Moves focus right, movefocus, r"
        "${mod}, UP, Moves focus up, movefocus, u"
        "${mod}, DOWN, Moves focus down, movefocus, d"
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
        "${mod}, Space, Opens fuzzel, exec, ${fuzzel} --show-actions --prompt '󱓞 '"
        "${mod}, V, Shows clipboard history, exec, ${cliphist} list | ${fuzzel} --dmenu --prompt '󱉧 ' | ${cliphist} decode | wl-copy -p -n"
        "${mod}, Return, Opens terminal, exec, uwsm app -- ${handlr "x-scheme-handler/terminal"}"
      ]
      ++ (lib.mapAttrsToList (n: key: "${mod}, ${key}, Switch to workspace ${n}, workspace, name:${n}") workspaces)
      ++ (lib.mapAttrsToList (n: key: "${modShift}, ${key}, Moves active window to workspace ${n}, movetoworkspacesilent, name:${n}") workspaces);

    binddle = [
      ", XF86MonBrightnessUp,   Increase brightness, exec, light -A 5"
      ", XF86MonBrightnessDown, Decrease brightness, exec, light -U 5"
      ", XF86AudioRaiseVolume, Increase volume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, Decrease volume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, Toggle output mute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, Toggle input mute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];
  };
}
