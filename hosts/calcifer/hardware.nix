{
  inputs,
  lib,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel-cpu-only
    common-gpu-amd
    common-pc-ssd

    ./filesystems.nix
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

  nix.settings.max-jobs = 20;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;

  swapDevices = lib.mkForce [];

  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";
}
