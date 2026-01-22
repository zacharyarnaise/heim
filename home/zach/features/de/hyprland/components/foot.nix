{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        shell = "${pkgs.fish}/bin/fish";
        selection-target = "primary";
        term = "xterm-256color";
      };
      bell = {
        notify = "no";
        visual = "yes";
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
        clipboard-copy = "Super+c XF86Copy";
        clipboard-paste = "Super+v XF86Paste";
        primary-paste = "Super+Shift+v";
        pipe-command-output = "[wl-copy -n] Control+Shift+h";
        pipe-visible = "[wl-copy -n] Control+Shift+j";
      };
      mouse.alternate-scroll-mode = "yes";
      url.osc8-underline = "always";
    };
  };
  systemd.user.services.foot = {
    Unit = {
      PartOf = lib.mkForce [config.wayland.systemd.target];
      After = lib.mkForce [config.wayland.systemd.target];
    };
    Install.WantedBy = lib.mkForce [config.wayland.systemd.target];
  };
}
