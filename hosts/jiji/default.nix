{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach

    ./modules/postgresql.nix
    ./modules/atuin.nix
  ];

  system.stateVersion = "25.05";
}
