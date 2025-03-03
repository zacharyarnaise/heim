{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach
  ];

  system.stateVersion = "24.11";
}
