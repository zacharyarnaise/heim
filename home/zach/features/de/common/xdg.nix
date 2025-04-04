{
  config,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
  shadowedXdgOpen = pkgs.writeShellScriptBin "xdg-open" ''
    handlr open "$@"
  '';
in {
  home.packages = [
    pkgs.handlr-regex
    shadowedXdgOpen
  ];

  xdg = {
    enable = true;
    mimeApps.enable = true;

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [pkgs.xdg-desktop-portal-wlr];
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
