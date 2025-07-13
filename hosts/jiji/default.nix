{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach

    ../common/optional/boot-quiet.nix
  ];

  system.stateVersion = "25.05";
}
