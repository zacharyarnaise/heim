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

      display-drun = "󱓞";
      display-run = "󰐣";
      display-ssh = "󰢹";
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
        anchor = l "north";
        location = l "north";
        y-offset = 6;
        width = l "32em";
        border-radius = l "1.5em";
      };
      mainbox.padding = l "0.75em";

      inputbar = {
        border-radius = l "1em";
        margin = l "0 0 0.4em 0";
        children = map l ["prompt" "entry"];
      };
      prompt = {
        font = "${config.stylix.fonts.monospace.name} 19";
        padding = l "1em 1.2em 1em 1em";
        background-color = l "@blue";
        text-color = lib.mkForce (l "@selected-normal-text");
      };
      entry = {
        font = "${config.stylix.fonts.sansSerif.name} 11";
        cursor = l "text";
        placeholder = ".  .  .";
        vertical-align = l "0.5";
        margin = l "0 0 0 0.9em";
      };

      textbox.padding = l "0.5em 1em";
      message = {
        border-radius = l "1em";
        margin = l "0.75em 0 0";
      };
      listview = {
        fixed-height = false;
        margin = l "0.75em 0 0";
        lines = 8;
        columns = 1;
      };

      "element normal.normal".background-color = lib.mkForce (l "transparent");
      "element alternate.normal".background-color = lib.mkForce (l "transparent");
      element = {
        padding = l "0.5em 1em";
        spacing = l "1em";
        border-radius = l "1em";
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
