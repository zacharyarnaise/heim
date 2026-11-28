{
  imports = [
    ./boot.nix
    ./filesystems.nix
    ./hardware.nix
    ./nvidia.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/boot/limine.nix
    ../common/optional/bluetooth.nix
  ];

  heim.wireguard.enable = true;

  system.stateVersion = "26.05";
}
