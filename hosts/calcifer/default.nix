{
  imports = [
    ./hardware.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/bluetooth.nix
    ../common/optional/boot-quiet.nix
  ];

  system.stateVersion = "25.05";
}
