# Configuration applicable to all my PCs
{
  imports = [
    ./all.nix
    ./optional/boot-efi.nix
    ./optional/pipewire.nix
    ./optional/resolved.nix
  ];

  networking = {
    nameservers = [
      "1.1.1.1#cloudflare-dns.com"
      "1.0.0.1#cloudflare-dns.com"
      "2606:4700:4700::1111#cloudflare-dns.com"
      "2606:4700:4700::1001#cloudflare-dns.com"
    ];
    useDHCP = true;
  };

  hardware = {
    opengl.enable = true;
  };
}
