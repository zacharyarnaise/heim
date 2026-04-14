{config, ...}: {
  services.hyprsunset = {
    enable = true;
    systemdTarget = config.wayland.systemd.target;

    settings.profile = [
      {
        time = "08:00";
        identity = true;
      }
      {
        time = "20:00";
        temperature = 4000;
      }
      {
        time = "23:00";
        temperature = 3000;
      }
    ];
  };
}
