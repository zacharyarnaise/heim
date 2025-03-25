{lib, ...}: {
  imports = [
    ./global

    ./optional/impermanence.nix
    ./optional/secureboot.nix
  ];

  nix = {
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedClass = "best-effort";
  };

  boot.kernelParams = ["nomodeset" "panic=1" "boot.panic_on_fail=1"];
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
