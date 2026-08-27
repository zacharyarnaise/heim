{
  imports = [
    ./hardware.nix
    ./wireguard.nix

    ../common/pc.nix
    ../common/optional/laptop
    ../common/users/zach

    ../common/optional/boot/limine.nix
    ../common/optional/bluetooth.nix
    ../common/optional/wireless.nix
  ];

  system.stateVersion = "26.05";
}
