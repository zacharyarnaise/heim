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
    kernel.sysctl."vm.dirty_writeback_centisecs" = "3000";
  };

  programs.light.enable = true;

  # Wireless is unstable, disabling power-saving stuff might help...
  networking.networkmanager.wifi.powersave = false;
  boot.extraModprobeConfig = ''
    options rtw89_core disable_ps_mode=y
    options rtw89_pci disable_clkreq=y disable_aspm_l1=y disable_aspm_l1ss=y
  '';

  nix.settings.max-jobs = 12;
  hardware.cpu.amd.updateMicrocode = true;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = "ondemand";
}
