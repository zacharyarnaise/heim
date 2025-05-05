{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/persist/etc/secureboot";
    };
    loader.systemd-boot.enable = lib.mkForce false;
  };
}
