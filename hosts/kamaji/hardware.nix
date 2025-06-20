{
  inputs,
  lib,
  pkgs,
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

  hardware.graphics = {
    enable = true;
    extraPackages = [pkgs.vpl-gpu-rt];
    extraPackages32 = [pkgs.pkgsi686Linux.vpl-gpu-rt];
  };

  nix.settings.max-jobs = 8;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = "ondemand";
}
