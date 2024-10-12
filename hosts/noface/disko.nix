{inputs, ...}: {
  imports = [inputs.disko.nixosModules.disko];

  disko.devices = {
    disk.main = {
      device = "/dev/sda";
      type = "disk";

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            type = "EF00";
            size = "500M";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["defaults" "noexec" "umask=0077"];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              askPassword = true;

              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                postCreateHook = ''
                  mkdir -p /tmp
                  MNTPOINT=$(mktemp -d)

                  echo "Mounting BTRFS volumes"
                  mount -t btrfs -o subvol=/ /dev/mapper/crypted "$MNTPOINT"
                  trap 'umount "$MNTPOINT"; rm -rf "$MNTPOINT"' EXIT

                  echo "Taking a snapshot of @root subvolume"
                  btrfs subvolume snapshot -r "$MNTPOINT/@root" "$MNTPOINT/@root-blank"
                '';
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=lzo" "noatime"];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["compress=lzo" "noatime"];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=lzo"
                      "noatime"
                      "lazytime"
                      "noacl"
                    ];
                  };
                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = ["compress=lzo" "noatime" "lazytime"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems = {
    "/persist".neededForBoot = true;
    "/var/log".neededForBoot = true;
  };
}
