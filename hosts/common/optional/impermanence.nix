{
  inputs,
  lib,
  config,
  ...
}: let
  rollbackScript = ''
    mkdir /tmp -p
    MNTPOINT=$(mktemp -d)

    echo "Mounting volumes"
    mount -t btrfs -o subvol=/ /dev/mapper/crypted "$MNTPOINT"
    trap 'umount "$MNTPOINT"; rm -rf "$MNTPOINT"' EXIT

    echo "Deleting @root subvolumes"
    btrfs subvolume list -o "$MNTPOINT/@root" | cut -f9 -d' ' | sort |
      while read -r subvolume; do
        btrfs subvolume delete "$MNTPOINT/$subvolume"
      done
    btrfs subvolume delete "$MNTPOINT/@root"

    echo "Restoring @root from @root-blank snapshot"
    btrfs subvolume snapshot "$MNTPOINT/@root-blank" "$MNTPOINT/@root"
  '';
in {
  imports = [inputs.impermanence.nixosModule];

  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/var/lib/nixos"
    ];

    files = [
      "/etc/machine-id"
    ];
  };

  # Prevent sudo lecture at each reboot
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';

  # Create persistent home directories for each user
  system.activationScripts.persistent-dirs.text = let
    mkHomePersist = user:
      lib.optionalString user.createHome ''
        mkdir -p /persist/${user.home}
        chown ${user.name}:${user.group} /persist/${user.home}
        chmod ${user.homeMode} /persist/${user.home}
      '';
    users = lib.attrValues config.users.users;
  in
    lib.concatLines (map mkHomePersist users);

  # systemd service in initrd to rollback root subvolume
  boot.initrd = {
    supportedFilesystems = ["btrfs"];
    systemd = {
      enable = true;
      services.rollback-root = {
        description = "Rollback BTRFS root subvolume to a pristine state";
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = rollbackScript;
        wantedBy = ["initrd.target"];
        after = ["systemd-cryptsetup@crypted.service"];
        before = ["sysroot.mount"];
      };

      suppressedUnits = ["systemd-machine-id-commit.service"];
    };
  };
  # see https://github.com/nix-community/impermanence/issues/229
  systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];
}
