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
      ./locale.nix
      ./networking.nix
      ./nix.nix
      ./openssh.nix
      ./secrets.nix
      ./userborn.nix
    ];

  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      coreutils
      pciutils
      ;
  };

  programs.nh = {
    enable = true;
  };

  hardware.enableAllFirmware = true;
  users.mutableUsers = false;

  # Disable unused stuff
  documentation.doc.enable = false;
  documentation.info.enable = false;
  services.speechd.enable = false;
}
