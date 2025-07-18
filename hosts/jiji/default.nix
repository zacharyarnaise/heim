{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach

    ./modules/bridge-net.nix
    ./modules/wireguard.nix
    ./modules/postgresql.nix
    ./modules/atuin.nix
  ];

  system.stateVersion = "25.05";
}
