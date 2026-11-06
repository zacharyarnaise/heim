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
      ./btrfs.nix
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
    systemPackages = [
      (lib.hiPrio pkgs.uutils-coreutils-noprefix)
      (lib.hiPrio pkgs.uutils-diffutils)
      (lib.hiPrio pkgs.uutils-findutils)

      pkgs.pciutils
    ];
    stub-ld.enable = false;
  };

  hardware.enableAllFirmware = true;
  users.mutableUsers = false;

  # Disable unused stuff
  documentation.doc.enable = false;
  documentation.info.enable = false;

  services.journald.settings.Journal.MaxRetentionSec = "30d";

  services.irqbalance.enable = true;
  systemd.services.irqbalance.serviceConfig.ProtectKernelTunables = "no";
}
