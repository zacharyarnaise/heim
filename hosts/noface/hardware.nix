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
    blacklistedKernelModules = [
      "pcspkr"
      "snd_hda_codec_hdmi"
      "snd_pcsp"
    ];
    kernelModules = [];
    extraModulePackages = [];
  };

  nix.settings.max-jobs = lib.mkDefault 2;
  swapDevices = lib.mkForce [];
  virtualisation.virtualbox.guest.enable = true;
}
