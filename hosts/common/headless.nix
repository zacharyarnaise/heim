{lib, ...}: {
  imports = [
    ./global

    ./optional/resolved.nix
    ./optional/impermanence.nix
  ];

  networking = {
    nameservers = [
      "1.1.1.1#cloudflare-dns.com"
      "1.0.0.1#cloudflare-dns.com"
      "2606:4700:4700::1111#cloudflare-dns.com"
      "2606:4700:4700::1001#cloudflare-dns.com"
    ];
    useDHCP = lib.mkDefault true;
  };

  nix = {
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedClass = "best-effort";
  };

  # Since we can't manually respond to a panic, just reboot.
  boot.kernelParams = ["nomodeset" "panic=1" "boot.panic_on_fail=1"];
  # Don't allow emergency mode, because we don't have a console.
  systemd.enableEmergencyMode = false;
  # Don't start a tty on the serial consoles.
  systemd.services."serial-getty@ttyS0".enable = lib.mkDefault false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;

  services.udisks2.enable = lib.mkDefault false;
}
