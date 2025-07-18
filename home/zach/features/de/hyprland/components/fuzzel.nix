{
  config,
  lib,
  ...
}: {
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=${toString config.stylix.fonts.sizes.popups}";
        fields = "filename,name,generic,exec";
        filter-desktop = true;
        terminal = "${config.programs.wezterm.package}/bin/wezterm";
        launch-prefix = "uwsm-app -- ";
        anchor = "top";
        y-margin = 20;
        width = 50;
        tabs = 2;
      };
      border.width = 1;
    };
  };
}
