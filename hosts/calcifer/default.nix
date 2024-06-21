{inputs, ...}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel-cpu-only
    common-gpu-amd
    common-pc-ssd

    ./hardware.nix

    ../common/pc.nix

    ../common/optional/bluetooth.nix
    ../common/optional/wireless-wpa_supplicant.nix
  ];

  networking = {
    hostName = "calcifer";
  };

  system.stateVersion = "24.05";
}
