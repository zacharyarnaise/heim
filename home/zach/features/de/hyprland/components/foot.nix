{pkgs, ...}: {
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        shell = "${pkgs.zsh}/bin/zsh";
      };
      cursor = {
        style = "block";
        beam-thickness = 2;
        blink = "yes";
      };
      url.protocols = "http,https";
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
