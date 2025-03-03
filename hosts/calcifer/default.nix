{
  imports = [
    ./hardware.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/bluetooth.nix
  ];

  system.stateVersion = "24.11";
}
