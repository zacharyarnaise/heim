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

  hardware.enableAllFirmware = true;
  users.mutableUsers = false;

  # Disable unused stuff
  documentation.doc.enable = false;
  documentation.info.enable = false;
  services.speechd.enable = false;

  services.irqbalance.enable = true;
  systemd = {
    services.journalctl-vacuum = {
      description = "Vacuum journalctl logs";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/journalctl --vacuum-time=23d";
      };
    };
    timers.journalctl-vacuum = {
      wantedBy = ["timers.target"];
      partOf = ["journalctl-vacuum.service"];
      timerConfig.OnCalendar = "weekly";
    };

    services.irqbalance.serviceConfig.ProtectKernelTunables = "no";
  };
}
