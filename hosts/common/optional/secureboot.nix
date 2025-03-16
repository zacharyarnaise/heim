{
  config,
  inputs,
  lib,
  ...
}: let
  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "${lib.optionalString hasOptinPersistence "/persist"}/etc/secureboot";
    };
    loader.systemd-boot.enable = lib.mkForce false;
  };
}
