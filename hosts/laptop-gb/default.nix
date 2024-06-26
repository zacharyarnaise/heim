{
  imports = [
    ./hardware.nix

    ../common/os/pc.nix
    ../common/users/zach

    ../common/os/optional/bluetooth.nix
    # ../common/os/optional/boot-quiet.nix
    ../common/os/optional/powertop.nix
    ../common/os/optional/wireless-wpa_supplicant.nix
  ];

  networking.hostName = "laptop-gb";

  system.stateVersion = "24.05";
}
