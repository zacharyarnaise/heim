{inputs, ...}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-gpu-amd
    common-pc-laptop-ssd

    ./hardware.nix

    ../common/pc.nix

    ../common/optional/bluetooth.nix
    ../common/optional/boot-quiet.nix
    ../common/optional/powertop.nix
    ../common/optional/wireless-wpa_supplicant.nix
  ];

  networking = {
    hostName = "laptop-gb";
  };

  system.stateVersion = "24.05";
}
