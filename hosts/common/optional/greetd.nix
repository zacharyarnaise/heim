{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      binPath = "/run/current-system/sw/bin/Hyprland";
      prettyName = "Hyprland";
      comment = "Hyprland (uwsm)";
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
          --remember --remember-session \
          --asterisks \
          --no-xsession-wrapper \
          --cmd "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop" \
          --theme 'border=red'
        '';
        user = "greeter";
      };
    };
  };

  # https://github.com/apognu/tuigreet/issues/68
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
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
