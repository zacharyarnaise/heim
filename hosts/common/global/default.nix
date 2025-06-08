{
  lib,
  pkgs,
  ...
}: {
  imports =
    (map lib.custom.relativeToRoot ["modules/nixos" "modules/common"])
    ++ [
      ./home-manager.nix

      ./boot.nix
      ./hardening.nix
      ./impermanence.nix
      ./locale.nix
      ./networking.nix
      ./nix.nix
      ./openssh.nix
      ./secrets.nix
      ./ssh.nix
      ./userborn.nix
    ];

  environment = {
    systemPackages = builtins.attrValues {
      inherit
        (pkgs)
        coreutils
        pciutils
        ;
    };
    stub-ld.enable = false;
  };

  systemd.sleep.extraConfig = ''
    AllowHibernation=no
  '';

  hardware.enableAllFirmware = true;
  users.mutableUsers = false;

  # Disable unused stuff
  documentation.doc.enable = false;
  documentation.info.enable = false;
  services.speechd.enable = false;
}
