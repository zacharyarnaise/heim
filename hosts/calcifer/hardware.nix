{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

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

  hardware.cpu.intel.updateMicrocode = true;
  nix.settings.max-jobs = 28;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  swapDevices = lib.mkForce [];
}
