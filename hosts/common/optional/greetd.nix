{pkgs, ...}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland (uwsm-managed)";
      binPath = "${pkgs.hyprland}/bin/Hyprland";
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          -g 'wake up...' \
          -t --time-format '%-d %B %H:%M:%S' \
          -r --remember-session \
          --asterisks \
          --sessions ${pkgs.uwsm}/share/wayland-sessions
        '';
        user = "greeter";
      };
    };
  };

  # https://github.com/apognu/tuigreet/issues/68
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    TTYReset = true;
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/cache/tuigreet";
        user = "greeter";
        group = "greeter";
        mode = "0755";
      }
    ];
  };
}
