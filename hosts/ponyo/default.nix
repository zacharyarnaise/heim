{
  imports = [
    ./hardware.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/bluetooth.nix
    ../common/optional/powertop.nix
    ../common/optional/wireless.nix
  ];

  system.stateVersion = "25.05";
}
