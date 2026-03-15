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
      enrollConfig = true;
      extraConfig = lib.concatLines [
        "remember_last_entry: yes"
      ];
      maxGenerations = 10;
      panicOnChecksumMismatch = true;
      secureBoot.enable = true;
      style = {
        interface = {
          branding = " ";
          helpHidden = true;
        };
        backdrop = "59514A";
        wallpapers = [./limine-bg.png];
        wallpaperStyle = "centered";
      };
    };
    timeout = 5;
  };

  environment.persistence."/persist" = {
    directories = [pkiBundle];
  };
}
