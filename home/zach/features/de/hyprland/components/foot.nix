{pkgs, ...}: {
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        shell = "${pkgs.zsh}/bin/zsh";
        selection-target = "clipboard";
      };
      cursor = {
        style = "block";
        blink = "yes";
      };
      scrollback = {
        lines = 5000;
        indicator-format = "line";
      };
      bell.visual = "yes";
      mouse.alternate-scroll-mode = "yes";
    };
  };

  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "foot.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "foot.desktop";
    };
  };
}
