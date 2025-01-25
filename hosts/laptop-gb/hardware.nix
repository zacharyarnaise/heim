{
  inputs,
  lib,
  pkgs,
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
    # No ticks on cores 4-7, improves battery life
    kernelParams = ["nohz_full=4-7"];
  };

  hardware = {
    amdgpu = {
      initrd.enable = true;
      legacySupport.enable = lib.mkForce false;
    };
    graphics = {
      extraPackages = [pkgs.amdvlk];
    };
  };

  nix.settings.max-jobs = 8;
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = "powersave";
}
