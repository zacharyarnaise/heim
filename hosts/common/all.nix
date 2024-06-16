# Configuration applicable to all hosts
{
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
    nixos.enable = false;
    info.enable = false;
  };

  hardware = {
    enableAllFirmware = true;
  };
}
