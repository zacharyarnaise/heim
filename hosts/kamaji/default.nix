{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach

    ../common/optional/boot-quiet.nix
    ../common/optional/usbguard.nix
  ];

  networking.hostId = "5d84e14a"; # for ZFS
  system.stateVersion = "24.11";
}
