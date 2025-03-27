{
  inputs,
  lib,
  config,
  ...
}: let
  diskLabel = "${config.hostSpec.name}-main";
  rollbackScript = ''
    mkdir /tmp -p
    MNTPOINT=$(mktemp -d)

    echo "Mounting volumes"
    mount -t btrfs -o subvol=/ /dev/disk/by-label/${diskLabel} "$MNTPOINT"
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
        requires = ["dev-disk-by\\x2dlabel-${diskLabel}.device"];
        before = ["sysroot.mount"];
        after = [
          "dev-disk-by\\x2dlabel-${diskLabel}.device"
          "systemd-cryptsetup@${diskLabel}.service"
        ];
      };
    };
  };
}
