{lib, ...}: {
  imports = [
    ./disko.nix
  ];

  boot.initrd.availableKernelModules = [
    "ohci_pci"
    "ehci_pci"
    "ahci"
    "nvme"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  nix.settings.max-jobs = lib.mkDefault 2;
  swapDevices = lib.mkForce [];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  virtualisation.virtualbox.guest.enable = true;
}
