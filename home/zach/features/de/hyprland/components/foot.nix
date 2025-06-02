{pkgs, ...}: {
  programs.foot = {
    enable = true;
    server.enable = false;

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
        pipe-command-output = "[wl-copy -n -p] Control+h";
        pipe-visible = "[wl-copy -n -p] Control+k";
      };
      bell.visual = "yes";
      mouse.alternate-scroll-mode = "yes";
    };
  };
}
