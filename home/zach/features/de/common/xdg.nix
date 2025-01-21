{
  config,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
in {
  home.packages = with pkgs; [
    xdg-utils
  ];

  xdg = {
    enable = true;
    mimeApps.enable = true;

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = ["gtk"];
    };

    userDirs = {
      enable = true;

      desktop = null;
      music = null;
      publicShare = null;
      templates = null;
      documents = "${home}/Documents";
      download = "${home}/Downloads";
      pictures = "${home}/Pictures";
      videos = "${home}/Videos";
      extraConfig.XDG_SCREENSHOTS_DIR = "${home}/Pictures/Screenshots";
    };
  };
}
