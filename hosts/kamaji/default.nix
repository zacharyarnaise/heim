{lib, ...}: {
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach

    ../common/optional/boot-quiet.nix
    ../common/optional/usbguard.nix
  ];

  boot = {
    supportedFilesystems = ["zfs"];
    zfs.forceImportRoot = false;
  };

  networking.hostId = lib.mkForce "5d84e14a"; # for ZFS
  system.stateVersion = "25.05";
}
