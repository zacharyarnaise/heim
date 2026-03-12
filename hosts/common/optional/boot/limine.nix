{lib, ...}: let
  pkiBundle = "/var/lib/sbctl";
in {
  boot.loader = {
    grub.enable = lib.mkForce false;
    systemd-boot.enable = lib.mkForce false;
    limine = {
      enable = true;

      biosSupport = false;
      efiInstallAsRemovable = false;
      efiSupport = true;
      enableEditor = false;
      extraConfig = lib.concatLines [
        "remember_last_entry: yes"
      ];
      maxGenerations = 10;
      secureBoot.enable = true;
      style.interface = {
        helpHidden = true;
      };
    };
    timeout = 5;
  };

  environment.persistence."/persist" = {
    directories = [pkiBundle];
  };
}
