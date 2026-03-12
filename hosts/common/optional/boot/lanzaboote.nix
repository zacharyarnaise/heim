{
  inputs,
  lib,
  ...
}: let
  pkiBundle = "/etc/secureboot";
in {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote

    ./systemd-boot.nix
  ];

  boot = {
    lanzaboote = {
      enable = true;
      inherit pkiBundle;

      autoEnrollKeys.enable = true;
      autoGenerateKeys.enable = true;
    };

    # Lanzaboote replaces the systemd-boot module.
    loader.systemd-boot.enable = lib.mkForce false;
  };

  environment.persistence."/persist" = {
    directories = [pkiBundle];
  };
}
