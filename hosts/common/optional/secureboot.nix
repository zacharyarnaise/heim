{
  config,
  lanzaboote,
  lib,
  pkgs,
  ...
}: let
  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  imports = [
    lanzaboote.nixosModules.lanzaboote
  ];

  environment.systemPackages = [
    pkgs.sbctl
  ];

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "${lib.optionalString hasOptinPersistence "/persist"}/etc/secureboot";
    };
    loader = {
      efi.canTouchEfiVariables = false;
      systemd-boot.enable = lib.mkForce false;
    };
  };
}
