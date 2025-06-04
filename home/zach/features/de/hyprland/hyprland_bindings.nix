{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  rofi = "${config.programs.rofi.package}/bin/rofi";
  foot = "${pkgs.foot}/bin/foot";
  wezterm = "${config.programs.wezterm.package}/bin/wezterm";
  clipse = "${config.services.clipse.package}/bin/clipse";
  qalculate = "${pkgs.qalculate-qt}/bin/qalculate-qt";
  grimblast = "${pkgs.grimblast}/bin/grimblast";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";

  mod = "SUPER";
  modAlt = "SUPER_ALT";
  modCtrl = "SUPER_CONTROL";
  modShift = "SUPER_SHIFT";

  workspaces =
    if config.hostSpec.kbdLayout == "fr"
    then {
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
    }
    else {
      "1" = "1";
      "2" = "2";
      "3" = "3";
      "4" = "4";
      "5" = "5";
      "6" = "6";
      "7" = "7";
      "8" = "8";
      "9" = "9";
      "10" = "0";
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
        "${mod},     Space, Opens rofi drun mode, exec, pkill rofi || ${rofi} -show drun"
        "${modCtrl}, Space, Opens rofi ssh mod, exec, pkill rofi || ${rofi} -show ssh -no-show-icons"
        "${modCtrl}, V, Open clipse, exec, pkill clipse || ${foot} -a clipse ${clipse}"
        "${modCtrl}, K, Open qalculate, exec, pkill qalculate || ${qalculate}"
        "${mod},     Return, Opens terminal, exec, uwsm-app -- ${wezterm}"

        # Screenshot
        ",      Print, Takes a screenshot of a region, exec, ${grimblast} --notify --freeze copy area"
        "SHIFT, Print, Takes a screenshot of the currently active output, exec, ${grimblast} --notify --freeze copy output"

        # Media
        ", XF86AudioMute, Toggle output mute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, Toggle input mute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", code:248, Toggle input mute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ]
      ++ (lib.mapAttrsToList (n: key: "${mod}, ${key}, Switch to workspace ${n}, workspace, name:${n}") workspaces)
      ++ (lib.mapAttrsToList (n: key: "${modShift}, ${key}, Moves active window to workspace ${n}, movetoworkspacesilent, name:${n}") workspaces);

    binddle = [
      ", XF86MonBrightnessUp,   Increase brightness, exec, light -A 5"
      ", XF86MonBrightnessDown, Decrease brightness, exec, light -U 5"
      ", XF86AudioRaiseVolume, Increase volume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, Decrease volume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];
  };
}
