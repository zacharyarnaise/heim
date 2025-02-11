{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

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
    kernelParams = [
      # No ticks on cores 4-7, improves battery life (hopefully).
      "nohz_full=4-7"
      # Force use of the thinkpad_acpi driver for backlight control.
      # This allows the backlight save/load systemd service to work.
      "acpi_backlight=native"
    ];
  };

  hardware = {
    amdgpu = {
      initrd.enable = true;
      legacySupport.enable = lib.mkForce false;
    };
  };

  programs.light.enable = true;

  wayland.windowManager.hyprland.settings.device = [
    {
      name = "synps/2-synaptics-touchpad";
      accel_profile = "adaptive";
      sensitivity = 0.5;
    }
    {
      name = "tpps/2-elan-trackpoint";
      accel_profile = "adaptive";
      sensitivity = 0;
    }
  ];

  nix.settings.max-jobs = 8;
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = "powersave";
}
