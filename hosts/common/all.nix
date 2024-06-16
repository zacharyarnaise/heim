# Configuration applicable to all hosts
{lib, ...}: {
  imports = [
    ./shared
    ./shared/boot.nix
    ./shared/locale.nix
    ./shared/networking.nix
    ./shared/nix-daemon.nix
    ./shared/security.nix
    ./shared/zsh.nix
  ];

  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    nixos.enable = lib.mkForce false;
    info.enable = false;
  };

  hardware = {
    enableAllFirmware = true;
  };
}
