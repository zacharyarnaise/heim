{
  imports = [
    ./hardware.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/bluetooth.nix
    ../common/optional/boot-quiet.nix
    ../common/optional/powertop.nix
  ];

  system.stateVersion = "24.11";
}
