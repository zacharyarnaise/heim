{
  config,
  pkgs,
  lib,
  ...
}: let
  mkBind = key: dispatcher: opts: {
    _args = [(lib.generators.mkLuaInline key) (lib.generators.mkLuaInline dispatcher)] ++ lib.optional (opts != {}) opts;
  };
  mkExec = key: cmd: desc:
    mkBind key "hl.dsp.exec_cmd([[${cmd}]])" {description = desc;};
  mkExecRepeat = key: cmd: desc:
    mkBind key "hl.dsp.exec_cmd([[${cmd}]])" {
      description = desc;
      repeating = true;
    };

  foot = "${pkgs.foot}/bin/footclient";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  noctalia = "${config.programs.noctalia.package}/bin/noctalia msg";
  nautilus = "${pkgs.nautilus}/bin/nautilus";
  qalculate = "${pkgs.qalculate-qt}/bin/qalculate-qt";

  mod = "SUPER";
  modCtrl = "SUPER + CONTROL";
  modShift = "SUPER + SHIFT";

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
  wayland.windowManager.hyprland.settings.bind =
    [
      # -------------------------------- Mouse --------------------------------
      (mkBind ''"${mod} + mouse:272"'' "hl.dsp.window.drag()" {mouse = true;})
      (mkBind ''"${mod} + mouse:273"'' "hl.dsp.window.resize()" {mouse = true;})

      # ----------------------------- Applications -----------------------------
      (mkExec ''"${mod} + E"'' "${nautilus}" "Open file manager")
      (mkExec ''"${mod} + K"'' "${qalculate}" "Open calculator")
      (mkExec ''"${mod} + Return"'' "${foot}" "Open terminal")

      # -------------------------------- Media --------------------------------
      (mkExec ''"code:248"'' "${noctalia} mic-mute" "Toggle input mute")
      (mkExec ''"XF86AudioMicMute"'' "${noctalia} mic-mute" "Toggle input mute")
      (mkExec ''"XF86AudioMute"'' "${noctalia} volume-mute" "Toggle output mute")
      (mkExecRepeat ''"XF86AudioLowerVolume"'' "${noctalia} volume-down" "Decrease output volume")
      (mkExecRepeat ''"XF86AudioRaiseVolume"'' "${noctalia} volume-up" "Increase output volume")
      (mkExecRepeat ''"XF86MonBrightnessDown"'' "${noctalia} brightness-down" "Decrease brightness")
      (mkExecRepeat ''"XF86MonBrightnessUp"'' "${noctalia} brightness-up" "Increase brightness")

      # --------------------------- Monitor movement ---------------------------
      (mkBind ''"${mod} + bracketleft"'' ''hl.dsp.focus({monitor = "-1"})'' {description = "Move focus to the previous monitor";})
      (mkBind ''"${mod} + bracketright"'' ''hl.dsp.focus({monitor = "+1"})'' {description = "Move focus to the next monitor";})
      (mkBind ''"${modShift} + bracketleft"'' ''hl.dsp.window.move({monitor = "-1"})'' {description = "Move active window to the previous monitor";})
      (mkBind ''"${modShift} + bracketright"'' ''hl.dsp.window.move({monitor = "+1"})'' {description = "Move active window to the next monitor";})

      # ------------------------------- Noctalia -------------------------------
      (mkExec ''"${mod} + End"'' "${noctalia} panel-toggle session" "Open session panel")
      (mkExec ''"${mod} + Space"'' "${noctalia} panel-toggle launcher" "Open launcher panel")
      (mkExec ''"${modCtrl} + V"'' "${noctalia} panel-toggle clipboard" "Open clipboard panel")
      (mkExec ''"Print"'' "${noctalia} screenshot-region" "Take a screenshot of a region")
      (mkExec ''"SHIFT + Print"'' "${noctalia} screenshot-fullscreen pick" "Take a screenshot of a monitor")

      # -------------------------------- Power --------------------------------
      (mkExec ''"${modShift} + End"'' "${loginctl} terminate-session" "Terminate session")
      (mkExec ''"${modShift} + L"'' "${loginctl} lock-session" "Lock session")

      # ---------------------------- Window control ----------------------------
      (mkBind ''"${mod} + F"'' ''hl.dsp.window.float()'' {description = "Toggle floating";})
      (mkBind ''"${mod} + P"'' ''hl.dsp.window.pseudo()'' {description = "Toggle pseudotile";})
      (mkBind ''"${mod} + S"'' "hl.dsp.window.fullscreen(1)" {description = "Toggle maximize";})
      (mkBind ''"${mod} + W"'' "hl.dsp.window.close()" {description = "Close the active window";})
      (mkBind ''"${modShift} + S"'' "hl.dsp.window.fullscreen(0)" {description = "Toggle fullscreen";})
      (mkBind ''"${modShift} + W"'' "hl.dsp.window.kill()" {description = "Kill the process owning the active window";})

      # --------------------------- Window movement ---------------------------
      (mkBind ''"${mod} + DOWN"'' ''hl.dsp.focus({direction = "d"})'' {description = "Move focus to the lower window";})
      (mkBind ''"${mod} + LEFT"'' ''hl.dsp.focus({direction = "l"})'' {description = "Move focus to the left window";})
      (mkBind ''"${mod} + RIGHT"'' ''hl.dsp.focus({direction = "r"})'' {description = "Move focus to the right window";})
      (mkBind ''"${mod} + UP"'' ''hl.dsp.focus({direction = "u"})'' {description = "Move focus to the upper window";})
      (mkBind ''"${modCtrl} + DOWN"'' ''hl.dsp.window.swap({direction = "d"})'' {description = "Swap the active window with the lower window";})
      (mkBind ''"${modCtrl} + LEFT"'' ''hl.dsp.window.swap({direction = "l"})'' {description = "Swap the active window with the left window";})
      (mkBind ''"${modCtrl} + RIGHT"'' ''hl.dsp.window.swap({direction = "r"})'' {description = "Swap the active window with the right window";})
      (mkBind ''"${modCtrl} + UP"'' ''hl.dsp.window.swap({direction = "u"})'' {description = "Swap the active window with the upper window";})
      (mkBind ''"${modShift} + DOWN"'' ''hl.dsp.window.move({direction = "d"})'' {description = "Move the active window down";})
      (mkBind ''"${modShift} + LEFT"'' ''hl.dsp.window.move({direction = "l"})'' {description = "Move the active window to the left";})
      (mkBind ''"${modShift} + RIGHT"'' ''hl.dsp.window.move({direction = "r"})'' {description = "Move the active window to the right";})
      (mkBind ''"${modShift} + UP"'' ''hl.dsp.window.move({direction = "u"})'' {description = "Move the active window up";})
    ]
    # --------------------------- Workspace movement ---------------------------
    ++ (lib.mapAttrsToList (n: key: mkBind ''"${mod} + ${key}"'' ''hl.dsp.focus({workspace = "${n}"})'' {description = "Move focus to workspace ${n}";}) workspaces)
    ++ (lib.mapAttrsToList (n: key: mkBind ''"${modShift} + ${key}"'' ''hl.dsp.window.move({workspace = "${n}"})'' {description = "Move the active window to workspace ${n}";}) workspaces);
}
