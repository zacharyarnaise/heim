{lib, ...}: {
  imports = [
    ./disko.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "virtio_pci"
      "virtio_scsi"
      "sd_mod"
      "sr_mod"
    ];
  };

  nix.settings.max-jobs = 2;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
