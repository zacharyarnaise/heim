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

      rofiOpacity = builtins.toString (
        builtins.ceil (config.stylix.opacity.popups * 100)
      );
      mkRgba = opacity: color: let
        c = config.lib.stylix.colors;
        r = c."${color}-rgb-r";
        g = c."${color}-rgb-g";
        b = c."${color}-rgb-b";
      in
        l "rgba ( ${r}, ${g}, ${b}, ${opacity} % )";
    in {
      "*" = {
        background-color = l "transparent";
        border-color = l "transparent";
        separatorcolor = l "transparent";

        background = mkRgba rofiOpacity "base00";
        lightbg = mkRgba rofiOpacity "base01";
        red = mkRgba rofiOpacity "base08";
        blue = mkRgba rofiOpacity "base0D";
        lightfg = mkRgba rofiOpacity "base06";
        foreground = mkRgba rofiOpacity "base05";

        base-text = "100" "base05";
        selected-normal-text = "100" "base01";
        selected-active-text = "100" "base00";
        selected-urgent-text = "100" "base00";
        normal-text = "100" "base05";
        active-text = "100" "base0D";
        urgent-text = "100" "base08";
        alternate-normal-text = "100" "base05";
        alternate-active-text = "100" "base0D";
        alternate-urgent-text = "100" "base08";
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
        background-color = l "@background";
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
        text-color = l "@base-text";
      };
      dummy.expand = true;

      element = {
        enabled = true;
        spacing = l "1em";
        padding = l "0.5em";
        cursor = l "pointer";
        text-color = l "@base-text";
      };
      "element selected.normal" = {
        background-color = l "@foreground";
        text-color = l "@selected-normal-text";
      };
      element-icon = {
        size = l "2.2em";
        cursor = l "inherit";
        text-color = l "inherit";
      };
      element-text = {
        vertical-align = l "0.5";
        horizontal-align = l "0.0";
        cursor = l "inherit";
        text-color = l "inherit";
      };

      error-message = {
        text-transform = l "capitalize";
        children = ["textbox"];
        background-color = l "@background";
        text-color = l "@urgent-text";
      };
      textbox = {
        vertical-align = l "0.5";
        horizontal-align = l "0.5";
        background-color = l "inherit";
        text-color = l "inherit";
      };
    };
  };
}
