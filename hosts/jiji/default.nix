{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/users/zach

    ./modules/networking.nix
    ./modules/wireguard.nix
    ./modules/postgresql.nix
    ./modules/atuin.nix
    ./modules/navidrome.nix
    ./modules/slskd.nix
  ];

  system.stateVersion = "26.05";
}
