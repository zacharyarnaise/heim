{
  imports = [
    ./hardware.nix
    ./wireguard.nix

    ../common/pc.nix
    ../common/optional/laptop
    ../common/users/zach

    ../common/optional/bluetooth.nix
    ../common/optional/wireless.nix
  ];

  system.stateVersion = "25.11";
}
