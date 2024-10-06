{lib, ...}: {
  imports = [
    ./disko.nix
  ];

  boot.initrd.availableKernelModules = [
    "ohci_pci"
    "ehci_pci"
    "ahci"
    "sd_mod"
    "sr_mod"
  ];

  nix.settings.max-jobs = lib.mkDefault 2;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  swapDevices = lib.mkForce [];

  virtualisation.virtualbox.guest.enable = true;
}
