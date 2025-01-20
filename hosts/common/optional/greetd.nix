{
  config,
  pkgs,
  ...
}: let
  baseSessionsDir = "${config.services.displayManager.sessionData.desktops}";
in {
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
          --sessions ${baseSessionsDir}/share/wayland-sessions \
          --theme border=green;text=lightgreen;prompt=lightgreen;time=white;action=lightgreen;button=green;container=darkgray;input=green
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
