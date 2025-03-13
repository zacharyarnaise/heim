{config, ...}: let
  iconThemeName =
    if (config.stylix.polarity == "dark")
    then config.stylix.iconTheme.dark
    else config.stylix.iconTheme.light;
  iconThemePath = "${config.stylix.iconTheme.package}/share/icons/${iconTheme}";
  iconHomePath = "${config.home.homeDirectory}/.nix-profile/share/icons/hicolor";
in {
  services.mako = {
    enable = true;

    actions = true;
    icons = true;
    iconPath = "${iconThemePath}:${iconHomePath}";
    format = "<span font_scale='subscript' rise='6pt' text_transform='capitalize'>%a</span>\\n<b>%s</b>\\n%b";
    defaultTimeout = 4000;
    maxVisible = 5;
    layer = "overlay";
    anchor = "top-center";
    groupBy = "summary";
    borderRadius = 8;
    borderSize = 0;
    height = 140;
    width = 400;
    margin = "5,0";
    padding = "12,20";
  };
}
