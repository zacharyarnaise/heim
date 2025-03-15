{
  config,
  lib,
  pkgs,
  ...
}: let
  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
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
