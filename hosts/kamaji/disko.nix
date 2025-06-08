{
  inputs,
  config,
  ...
}: {
  imports = [inputs.disko.nixosModules.disko];

  disko.devices = {
    disk = {
      main = {
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
                mountOptions = ["defaults" "noexec" "umask=0077"];
              };
            };

            main = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f" "-L${config.hostSpec.name}-main"];

                subvolumes = {
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
      store1 = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zstorage";
              };
            };
          };
        };
      };
    };

    zpool = {
      zstorage = {
        type = "zpool";
        options.ashift = "12";
        rootFsOptions = {
          atime = "off";
          compression = "lz4";
          "com.sun:auto-snapshot" = "false";
          dnodesize = "auto";
          mountpoint = "none";
          acltype = "posixacl";
          xattr = "sa";
        };

        datasets = {
          storage = {
            type = "zfs_fs";
            mountpoint = "/storage";
            options.recordsize = "1M";
          };
        };
      };
    };
  };

  nodev."/" = {
    fsType = "tmpfs";
    mountOptions = ["defaults" "noatime" "mode=755" "size=2G"];
  };

  fileSystems = {
    "/persist".neededForBoot = true;
    "/var/log".neededForBoot = true;
  };
}
