{config, ...}: {
  services.hyprsunset = {
    enable = false;
    systemdTarget = config.wayland.systemd.target;

    settings.profile = [
      {
        time = "08:00";
        identity = true;
        gamma = 1.0;
      }
      {
        time = "20:00";
        gamma = 0.8;
        temperature = 4000;
      }
      {
        time = "23:00";
        gamma = 0.8;
        temperature = 3000;
      }
    ];
  };
}
