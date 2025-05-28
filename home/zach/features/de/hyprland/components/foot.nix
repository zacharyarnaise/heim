{pkgs, ...}: {
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        shell = "${pkgs.zsh}/bin/zsh";
        selection-target = "both";
        term = "xterm-256color";
      };
      cursor = {
        style = "block";
        blink = "yes";
      };
      scrollback = {
        lines = 5000;
        indicator-format = "line";
      };
      key-bindings = {
        scrollback-up-page = "Control+u";
        scrollback-down-page = "Control+d";
        pipe-command-output = "[wl-copy -n] Control+Shift+g";
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
