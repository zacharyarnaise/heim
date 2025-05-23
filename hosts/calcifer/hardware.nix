{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./filesystems.nix
    ./nvidia.nix
  ];

  boot = {
    extraModulePackages = [config.boot.kernelPackages.ddcci-driver];
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = [
      "kvm-intel"
      "ddcci"
      "ddcci-backlight"
      "i2c-dev"
    ];
  };
  services.udev.packages = [pkgs.ddcutil];

  time.hardwareClockInLocalTime = true; # Fix clock drift on dual boot
  nix.settings.max-jobs = 28;
  hardware.cpu.intel.updateMicrocode = true;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
