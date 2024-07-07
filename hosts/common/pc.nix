# Configuration applicable to all my PCs
{
  imports = [
    ./all

    ./optional/pipewire.nix
    ./optional/resolved.nix
    ./optional/impermanence.nix
  ];

  boot.kernelParams = ["nowatchdog"];

  networking = {
    nameservers = [
      "1.1.1.1#cloudflare-dns.com"
      "1.0.0.1#cloudflare-dns.com"
      "2606:4700:4700::1111#cloudflare-dns.com"
      "2606:4700:4700::1001#cloudflare-dns.com"
    ];
    useDHCP = true;
  };

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };

  hardware.graphics.enable = true;
}
