{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  environment.systemPackages = [pkgs.sbctl];

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "${lib.optionalString hasOptinPersistence "/persist"}/etc/secureboot";
    };
    loader = {
      efi.canTouchEfiVariables = lib.mkForce false;
      systemd-boot.enable = lib.mkForce false;
    };
  };
}
