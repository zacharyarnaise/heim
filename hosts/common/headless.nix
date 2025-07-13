{lib, ...}: {
  imports = [
    ./global
  ];

  nix = {
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedClass = "best-effort";
  };

  boot.kernelParams = ["panic=1" "boot.panic_on_fail=1"];
  systemd = {
    enableEmergencyMode = false;
    services = {
      "serial-getty@ttyS0".enable = lib.mkDefault false;
      "serial-getty@hvc0".enable = false;
      "getty@tty1".enable = false;
      "autovt@".enable = false;
    };
  };
}
