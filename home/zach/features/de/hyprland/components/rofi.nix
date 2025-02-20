{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;

    location = "center";
    terminal = "${pkgs.foot}/bin/footclient";
    extraConfig = {
      modi = "drun,run,ssh";
      run-command = "uwsm app -- {cmd}";
      show-icons = true;
      window-format = "{w}{t}";

      display-drun = " ";
      display-run = " ";
      display-ssh = "󰣀 ";
      drun-display-format = "{name}";
    };

    theme = let
      l = config.lib.formats.rasi.mkLiteral;
    in {
      window = {
        enabled = true;
        fullscreen = false;
        cursor = "default";
        height = l "30em";
        width = l "36em";
        spacing = l "0em";
        padding = l "0em";
        transparency = "real";
      };
      mainbox = {
        enabled = true;
        spacing = l "0em";
        padding = l "0em";
        orientation = "horizontal";
        children = ["inputbar" "mode-switcher" "listbox"];
      };

      inputbar = {
        enabled = true;
        width = l "0em";
        children = ["entry"];
      };
      entry.enabled = false;

      mode-switcher = {
        expand = true;
        width = l "8em";
        orientation = "vertical";
        spacing = l "1em";
        padding = l "3em 1.8em 3em 1.8em";
      };
      button = {
        cursor = "pointer";
        border-radius = l "3em";
      };
      button-selected = {
        border-radius = l "3em";
      };

      listbox = {
        orientation = "vertical";
        spacing = l "0em";
        padding = l "0em";
        children = ["dummy" "listview" "dummy"];
        background-color = l "transparent";
      };
      listview = {
        enabled = true;
        spacing = l "0em";
        padding = l "1em";
        columns = 1;
        lines = 7;
        layout = l "vertical";
        cycle = true;
        dynamic = true;
        expand = false;
        fixed-height = true;
        fixed-columns = true;
        reverse = false;
        scrollbar = false;
      };

      element = {
        enabled = true;
        orientation = l "horizontal";
        spacing = l "1.5em";
        padding = l "0.5em";
        cursor = l "pointer";
      };
      element-icon = {
        size = l "3em";
        cursor = l "inherit";
      };
      element-text = {
        vertical-align = l "0.5";
        horizontal-align = l "0";
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
