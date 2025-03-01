{
  imports = [
    ./hardware.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/bluetooth.nix
  ];

  networking.hostName = "calcifer";

  system.stateVersion = "24.11";
}
