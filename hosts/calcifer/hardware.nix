{
  inputs,
  lib,
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
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = ["kvm-intel"];
  };

  nix.settings.max-jobs = 28;
  hardware.cpu.intel.updateMicrocode = true;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";
}
