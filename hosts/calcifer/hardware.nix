{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./filesystems.nix
    ./nvidia.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = [
      "kvm-intel"
      "nct6683"
      "i2c-dev"
    ];
    kernelParams = [
      "i8042.nopnp=1"
    ];
  };

  services.pipewire = {
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [44100 48000 88200 96000];
        };
      };
    };
    wireplumber.extraConfig = {
      "id24-sink-config" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                "node.name" = "alsa_output.usb-Audient_Audient_iD24-00.multichannel-output";
              }
            ];
            actions = {
              update-props = {
                "audio.format" = "S32LE";
                "audio.rate" = 96000;
              };
            };
          }
        ];
      };
    };
  };

  nix.settings.max-jobs = 28;
  hardware.cpu.intel.updateMicrocode = true;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
