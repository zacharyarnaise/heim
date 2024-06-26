{
  inputs,
  lib,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-gpu-amd
    common-pc-laptop-ssd

    ./disko.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = ["kvm-amd"];
  };

  nix.settings.max-jobs = 8;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;

  swapDevices = lib.mkForce [];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
