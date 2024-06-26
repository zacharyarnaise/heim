{
  imports = [
    ./hardware.nix

    ../common/os/pc.nix

    ../common/os/optional/bluetooth.nix
    ../common/os/optional/wireless-wpa_supplicant.nix
  ];

  networking.hostName = "calcifer";

  system.stateVersion = "24.05";
}
