{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./disko.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "sd_mod"
    ];
    blacklistedKernelModules = [
      "cec"
      "drm_display_helper"
      "i8042"
    ];
  };

  nix.settings.max-jobs = 8;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = "ondemand";
}
