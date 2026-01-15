{config, ...}: let
  iconThemeName =
    if (config.stylix.polarity == "dark")
    then config.stylix.icons.dark
    else config.stylix.icons.light;
  iconThemePath = "${config.stylix.icons.package}/share/icons/${iconThemeName}";
  iconHomePath = "${config.home.homeDirectory}/.nix-profile/share/icons/hicolor";
  iconSystemPath = "/run/current-system/sw/share/icons/hicolor";
in {
  services.mako = {
    enable = true;

    settings = {
      actions = true;
      icons = true;
      max-icon-size = 48;
      icon-path = "${iconThemePath}:${iconHomePath}:${iconSystemPath}";
      format = "<b>%s</b>\\n%b";
      default-timeout = 6000;
      max-visible = 5;
      layer = "overlay";
      anchor = "top-center";
      group-by = "summary";
      border-radius = 8;
      border-size = 0;
      height = 140;
      width = 400;
      margin = "5,0";
      padding = "12,20";
      output = config.primaryMonitor.name;
    };
  };
}
