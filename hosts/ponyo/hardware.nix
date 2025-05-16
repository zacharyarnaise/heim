{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen5

    ./disko.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = ["kvm-amd"];
  };

  programs.light.enable = true;

  nix.settings.max-jobs = 12;
  hardware.cpu.amd.updateMicrocode = true;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = "ondemand";
}
