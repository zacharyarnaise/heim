{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    
    font = lib.mkForce "${config.stylix.fonts.sansSerif.name} ${toString config.stylix.fonts.sizes.popups}";
    terminal = "${pkgs.foot}/bin/footclient";
    extraConfig = {
      modi = "drun,run,ssh";
      run-command = "uwsm app -- {cmd}";
      show-icons = true;
      window-format = "{w}{t}";
      drun-display-format = "{name}";

      display-drun = "🚀";
      display-run = "🔨";
      display-ssh = "🕷";
    };

    theme = let
      l = config.lib.formats.rasi.mkLiteral;
    in {
      "*" = {
        background-color = lib.mkForce (l "transparent");
        border = 0;
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      window = {
        enabled = true;
        fullscreen = false;
        anchor = l "north";
        location = l "north";
        y-offset = 15;
        width = l "32em";
        border-radius = l "1.5em";
      };
      mainbox = {
        enabled = true;
        padding = l "0.75em";
      };
      inputbar = {
        enabled = true;
        border = l "0.12em";
        border-radius = l "1em";
        padding = l "0.5em 1em";
        spacing = l "0.5em";
        children = ["prompt" "entry"];
      };
      message = {
        border-radius = l "1em";
        margin = l "0.75em 0 0";
      };
      textbox = {
        padding = l "0.5em 1em";
      };
      listview = {
        fixed-height = false;
        margin = l "0.75em 0 0";
        lines = 8;
        columns = 1;
      };

      element = {
        padding = l "0.5em 1em";
        spacing = l "1em";
        border-radius = l "1em";
      };
      "element normal.normal, element alternate.normal" = {
        background-color = lib.mkForce (l "transparent");
      };
      element-icon = {
        background-color = lib.mkForce (l "transparent");
        size = l "1.8em";
      };
      element-text = {
        background-color = lib.mkForce (l "transparent");
        vertical-align = l "0.5";
      };
    };
  };
}
