{
  lib,
  config,
  pkgs,
  ...
}: {
  stylix.targets.rofi.enable = lib.mkDefault false;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    location = "center";
    terminal = "${pkgs.foot}/bin/footclient";
    extraConfig = {
      modi = "drun,run,ssh";
      run-command = "uwsm app -- {cmd}";
      drun-display-format = "{name}";
      show-icons = true;
      window-format = "{w}{t}";
      font = "${config.stylix.fonts.serif.name} ${toString config.stylix.fonts.sizes.popups}";
      display-drun = " ";
      display-run = " ";
      display-ssh = "󰣀 ";
    };

    theme = let
      l = config.lib.formats.rasi.mkLiteral;
    in {
      "*" = {
        background-color = l "transparent";
        border-color = l "transparent";
      };

      window = {
        enabled = true;
        fullscreen = false;
        cursor = "default";
        height = l "30em";
        width = l "60em";
        spacing = l "0em";
        padding = l "0em";
        transparency = "real";
      };
      mainbox = {
        enabled = true;
        spacing = l "0em";
        padding = l "0em";
        orientation = "horizontal";
        children = ["listbox" "inputbar"];
      };

      inputbar = {
        enabled = true;
        expand = false;
        width = l "30em";
        spacing = l "0em";
        padding = l "0em";
        children = ["entry"];
        background-image = l "url(\"${../../../../wallpapers/l8kmop.rofi.png}\", width)";
      };
      entry.enabled = false;

      listbox = {
        expand = false;
        width = l "27em";
        spacing = l "0em";
        padding = l "0em";
        children = ["dummy" "listview" "dummy"];
      };
      listview = {
        enabled = true;
        spacing = l "0em";
        padding = l "1em 2em 1em 2em";
        columns = 1;
        lines = 8;
        layout = l "vertical";
        cycle = true;
        dynamic = true;
        expand = false;
        fixed-height = true;
        fixed-columns = true;
        reverse = false;
        scrollbar = false;
      };
      dummy.expand = true;

      element = {
        enabled = true;
        spacing = l "1em";
        padding = l "0.5em";
        cursor = l "pointer";
      };
      element-icon = {
        size = l "2.2em";
        cursor = l "inherit";
      };
      element-text = {
        vertical-align = l "0.5";
        horizontal-align = l "0.0";
        cursor = l "inherit";
      };

      error-message = {
        text-transform = l "capitalize";
        children = ["textbox"];
      };
      textbox = {
        vertical-align = l "0.5";
        horizontal-align = l "0.5";
      };
    };
  };
}
