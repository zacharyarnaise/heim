{
  lib,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    initrd.systemd.enable = true;

    loader = {
      timeout = lib.mkDefault 3;
      supportedFilesystems = ["btrfs"];

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub.enable = lib.mkForce false;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
        editor = false;
      };
    };

    plymouth.enable = false;
  };

  console.earlySetup = lib.mkDefault true;
}
