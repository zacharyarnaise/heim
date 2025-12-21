{lib, ...}: {
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach
    ../common/optional/display-manager.nix
    ../common/optional/pipewire.nix

    ./modules/networking.nix
    ./modules/wireguard.nix
    ./modules/nixarr.nix
    ./modules/samba.nix

    ./users/tv.nix
  ];

  boot = {
    supportedFilesystems = ["zfs"];
    zfs.forceImportRoot = false;
  };

  networking.hostId = lib.mkForce "5d84e14a"; # for ZFS
  system.stateVersion = "25.11";
}
