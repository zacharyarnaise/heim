{pkgs, ...}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland (uwsm-managed)";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --greeting 'wake up...' \
          --time --time-format '%-d %B %H:%M:%S' \
          --remember \
          --asterisks \
          --cmd ${pkgs.uwsm} start hyprland-uwsm.desktop
        '';
        user = "greeter";
      };
    };
  };

  # https://github.com/apognu/tuigreet/issues/68
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    TTYReset = true;
    TTYVTDisallocate = true;
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
