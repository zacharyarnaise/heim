{
  inputs,
  lib,
  config,
  ...
}: let
  rollbackScript = ''
    mkdir /tmp -p
    MNTPOINT=$(mktemp -d)

    BTRFS_VOL=/dev/mapper/crypted
    BTRFS_ROOT="$MNTPOINT/root"
    BTRFS_BLANK="$MNTPOINT/root-blank"

    echo "Mounting BTRFS root..."
    mount -t btrfs -o subvol=/ "$BTRFS_VOL" "$MNTPOINT"
    trap 'umount "$MNTPOINT"; rm -rf "$MNTPOINT"' EXIT

    echo "Cleaning up root subvolume..."
    btrfs subvolume list -o "$BTRFS_ROOT" | cut -d' ' -f9 |
      while read -r subvolume; do
        echo 'Deleting "$subvolume" subvolume...'
        btrfs subvolume delete "$MNTPOINT/$subvolume"
      done &&
      echo 'Deleting root subvolume...' && btrfs subvolume delete "$BTRFS_ROOT"

    echo "Restoring blank root subvolume..."
    btrfs subvolume snapshot "$BTRFS_BLANK" "$BTRFS_ROOT"
  '';
in {
  imports = [inputs.impermanence.nixosModule];

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/nixos"
      "/var/lib/systemd"
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

  boot.initrd = {
    systemd.enable = true;
    supportedFilesystems = ["btrfs"];
  };
  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume to a pristine state";
    wantedBy = ["initrd.target"];
    after = ["systemd-cryptsetup@crypted.service"];
    before = ["sysroot.mount"];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = rollbackScript;
  };
}
