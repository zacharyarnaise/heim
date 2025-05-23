{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach
  ];

  system.stateVersion = "25.05";
}
