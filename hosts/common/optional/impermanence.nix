{
  inputs,
  lib,
  config,
  ...
}: let
  rollbackScript = ''
    mkdir /tmp -p
    MNTPOINT=$(mktemp -d)

    echo "Mounting BTRFS volumes"
    mount -t btrfs -o subvol=/ /dev/mapper/crypted "$MNTPOINT"
    trap 'umount "$MNTPOINT"; rm -rf "$MNTPOINT"' EXIT

    btrfs subvolume list -o "$MNTPOINT/@root" | cut -f9 -d' ' | sort |
      while read -r subvolume; do
        echo "Deleting $subvolume"
        btrfs subvolume delete "$MNTPOINT/$subvolume"
      done

    echo "Deleting @root subvolume"
    btrfs subvolume delete "$MNTPOINT/@root"

    echo "Restoring blank root subvolume"
    btrfs subvolume snapshot "$MNTPOINT/@root-blank" "$MNTPOINT/@root"
  '';
in {
  imports = [inputs.impermanence.nixosModule];

  environment.persistence."/persist" = {
    hideMounts = false;

    directories = [
      "/etc/nixos"
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
        requires = ["dev-disk-by\\x2dlabel-crypted.device"];
        after = [
          "dev-disk-by\\x2dlabel-crypted.device"
          "systemd-cryptsetup@crypted.service"
        ];
        before = ["sysroot.mount"];
      };
    };
  };
}
