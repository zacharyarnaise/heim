{lib, ...}: {
  imports = [
    ./global

    ./optional/resolved.nix
    ./optional/impermanence.nix
  ];

  boot.kernelParams = ["nomodeset" "panic=1" "boot.panic_on_fail=1"];

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
}
