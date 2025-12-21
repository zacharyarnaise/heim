{config, ...}: {
  services.clipse = {
    enable = true;

    allowDuplicates = false;
    historySize = 500;
    systemdTarget = config.wayland.systemd.target;
  };
}
