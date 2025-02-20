{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;

    extraConfig = {
      modi = "drun,run,ssh";
      run-command = "uwsm app -- {cmd}";
      show-icons = true;
      ssh-client = "ssh";
    };
  };

  programs.gdk-pixbuf.modulePackages = [pkgs.librsvg];
}
