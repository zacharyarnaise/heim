{lib, ...}: {
  imports = [
    ./global

    ./optional/boot/systemd-boot.nix
  ];

  boot.kernelParams = ["panic=1" "boot.panic_on_fail=1"];

  documentation = {
    enable = false;
    doc.enable = false;
    info.enable = false;
    man.enable = false;
    nixos.enable = false;
  };

  nix = {
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedClass = "best-effort";
  };

  powerManagement.enable = false;

  systemd = {
    enableEmergencyMode = false;
    services = {
      "autovt@".enable = lib.mkForce false;
      "getty@".enable = lib.mkForce false;
      "serial-getty@".enable = lib.mkForce false;
    };
  };
}
