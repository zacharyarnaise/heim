{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    cycle = true;
    terminal = "${pkgs.foot}/bin/foot";
    extraConfig = {
      modi = "drun,filebrowser,window,run";
      drun-display-format = "{name}";
      show-icons = true;
      window-format = "{w}{t}";
      display-drun = " ";
      display-run = " ";
      display-filebrowser = "󱧶 ";
      display-window = " ";
    };
    # Reference: https://github.com/prasanthrangan/hyprdots
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      window = {
        enabled = true;
        fullscreen = false;
        cursor = "default";
        height = mkLiteral "30em";
        width = mkLiteral "60em";
        spacing = mkLiteral "0em";
        padding = mkLiteral "0em";
        transparency = "real";
      };
      mainbox = {
        enabled = true;
        spacing = mkLiteral "0em";
        padding = mkLiteral "0em";
        orientation = "horizontal";
        children = ["listbox" "inputbar"];
      };

      inputbar = {
        enabled = true;
        expand = false;
        width = mkLiteral "30em";
        spacing = mkLiteral "0em";
        padding = mkLiteral "0em";
        children = ["entry"];
      };
      entry.enabled = false;

      listbox = {
        expand = false;
        width = mkLiteral "27em";
        spacing = mkLiteral "0em";
        padding = mkLiteral "0em";
        children = ["dummy" "listview" "dummy"];
      };
      listview = {
        enabled = true;
        spacing = mkLiteral "0em";
        padding = mkLiteral "1em 2em 1em 2em";
        columns = 1;
        lines = 8;
        layout = mkLiteral "vertical";
        cycle = true;
        dynamic = true;
        expand = false;
        fixed-height = true;
        fixed-columns = true;
        reverse = false;
        scrollbar = false;
      };
      dummy = {
        expand = true;
      };

      element = {
        enabled = true;
        spacing = mkLiteral "1em";
        padding = mkLiteral "0.5em";
        cursor = mkLiteral "pointer";
      };
      element-icon = {
        size = mkLiteral "2.2em";
        cursor = mkLiteral "inherit";
      };
      element-text = {
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        cursor = mkLiteral "inherit";
      };

      error-message = {
        text-transform = mkLiteral "capitalize";
        children = ["textbox"];
      };
      textbox = {
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.5";
      };
    };
  };
}
