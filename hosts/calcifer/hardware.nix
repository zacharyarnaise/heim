{
  inputs,
  lib,
  pkgs,
  ...
}: let
  # Fix A2DP - HFP switch
  # See: https://github.com/abrus861/pipewire-hfp-atbcc-fix
  # See: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/5506
  pipewire_patched = pkgs.pipewire.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [./pipewire_keep-transport-at-bcs.patch];
  });
in {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  services.pipewire = {
    package = pipewire_patched;
    wireplumber.package = pkgs.wireplumber.override {pipewire = pipewire_patched;};
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

  hardware = {
    cpu.intel.updateMicrocode = true;
    i2c.enable = true;
  };
  nix.settings.max-jobs = 28;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  swapDevices = lib.mkForce [];
}
