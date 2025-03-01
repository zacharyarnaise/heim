{lib, ...}: {
  imports = [
    ./disko.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "ohci_pci"
        "ehci_pci"
        "ahci"
        "nvme"
        "sr_mod"
      ];
      kernelModules = [];
    };
    kernelModules = [];
    extraModulePackages = [];
  };

  nix.settings.max-jobs = lib.mkDefault 2;
  swapDevices = lib.mkForce [];
  virtualisation.virtualbox.guest.enable = true;
}
