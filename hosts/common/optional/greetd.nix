{
  wayland.sessions = [
    {
      name = "Hyprland";
      exec = "Hyprland";
    }
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --greeting 'wake up...' \
          --time --time-format '%-d %B %H:%M:%S' \
          --remember --remember-session \
          --asterisks \
          --no-xsession-wrapper \
          --sessions /etc/wayland-sessions \
          --theme 'border=red'
        '';
        user = "greetr";
      };
    };
  };

  # https://github.com/apognu/tuigreet/issues/68
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardError = "journal";
    TTYReset = true;
    TTYVTDisallocate = true;
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/cache/tuigreet";
        user = "greetr";
        group = "greetr";
        mode = "0755";
      }
    ];
  };
}
