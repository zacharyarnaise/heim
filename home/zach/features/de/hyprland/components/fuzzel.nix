{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        fields = "filename,name,generic,exec";
        filter-desktop = true;
        terminal = "${pkgs.foot}/bin/footclient";
        launch-prefix = "uwsm app --";
        anchor = "top";
        y-margin = 40;
        width = 50;
        tabs = 2;
      };
      border.width = 1;
    };
  };
}
