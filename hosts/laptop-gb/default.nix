{
  imports = [
    ./hardware.nix

    ../common/pc.nix

    ../common/optional/bluetooth.nix
    ../common/optional/boot-quiet.nix
    ../common/optional/powertop.nix
    ../common/optional/wireless-wpa_supplicant.nix
  ];

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/power-profiles-daemon"
      "/var/lib/upower"
    ];
  };

  networking.hostName = "laptop-gb";

  system.stateVersion = "24.05";
}
