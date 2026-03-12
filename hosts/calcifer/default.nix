{
  imports = [
    ./boot.nix
    ./filesystems.nix
    ./hardware.nix
    ./nvidia.nix
    ./wireguard.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/boot/limine.nix
    ../common/optional/bluetooth.nix
  ];

  system.stateVersion = "25.11";
}
