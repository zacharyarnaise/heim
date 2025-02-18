{
  imports = [
    ./hardware.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/bluetooth.nix
    ../common/optional/boot-quiet.nix
    ../common/optional/powertop.nix
    ../common/optional/wireless.nix
  ];

  hostSpec = {
    isLaptop = true;
    isWork = true;
  };

  networking.hostName = "laptop-gb";
  system.stateVersion = "24.11";
}
