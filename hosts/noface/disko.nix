{inputs, ...}: {
  imports = [inputs.disko.nixosModules.disko];

  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";

      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "EF00";
            size = "512M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["defaults" "noexec" "nosuid" "nodev" "umask=0077"];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              askPassword = true;
              postCreateHook = ''
                mkdir /tmp -p
                MNTPOINT=$(mktemp -d)

                mount -t btrfs -o subvol=/ /dev/mapper/crypted "$MNTPOINT"
                trap 'umount "$MNTPOINT"; rm -rf "$MNTPOINT"' EXIT

                btrfs subvolume snapshot -r "$MNTPOINT/@root" "$MNTPOINT/@root-blank"
              '';

              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd:1" "noatime"];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["compress=zstd:1" "noatime"];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd:1"
                      "noatime"
                      "lazytime"
                    ];
                  };
                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = ["compress=zstd:1" "noatime" "lazytime" "nosuid" "nodev" "noexec"];
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
