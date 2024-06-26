{
  imports = [
    ./hardware.nix

    ../common/pc.nix

    ../common/optional/bluetooth.nix
    ../common/optional/wireless-wpa_supplicant.nix
  ];

  networking.hostName = "calcifer";

  system.stateVersion = "24.05";
}
