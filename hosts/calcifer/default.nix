{
  imports = [
    ./hardware.nix
    ./wireguard.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/bluetooth.nix
  ];

  system.stateVersion = "25.11";
}
