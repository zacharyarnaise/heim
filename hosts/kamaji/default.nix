{lib, ...}: {
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach

    ../common/optional/usbguard.nix

    ./modules/networking.nix
    ./modules/wireguard.nix
    ./modules/nixarr.nix
    ./modules/samba.nix
  ];

  boot = {
    supportedFilesystems = ["zfs"];
    zfs.forceImportRoot = false;
  };

  networking.hostId = lib.mkForce "5d84e14a"; # for ZFS
  system.stateVersion = "25.05";
}
