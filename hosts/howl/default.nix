{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach
  ];

  networking.hostName = "howl";

  system.stateVersion = "24.05";
}
