{inputs, ...}: {
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
    kernel.sysctl."vm.dirty_writeback_centisecs" = "3000";
  };

  programs.light.enable = true;

  nix.settings.max-jobs = 12;
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "ondemand";
}
