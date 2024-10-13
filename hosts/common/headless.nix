# Configuration applicable to my headless devices
{lib, ...}: {
  imports = [
    ./all

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

  hardware.graphics.enable = lib.mkDefault false;
}
