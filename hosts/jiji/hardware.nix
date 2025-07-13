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

    loader = {
      systemd-boot.enable = lib.mkForce false;
      grub.enable = true;
    };
  };

  nix.settings.max-jobs = 2;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
