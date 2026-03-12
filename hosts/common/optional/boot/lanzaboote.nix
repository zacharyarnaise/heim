{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote

    ./systemd-boot.nix
  ];

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/persist/etc/secureboot";
    };

    # Lanzaboote replaces the systemd-boot module.
    loader.systemd-boot.enable = lib.mkForce false;
  };
}
