{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach

    ../common/optional/boot-quiet.nix
    ../common/optional/usbguard.nix
  ];

  system.stateVersion = "24.11";
}
