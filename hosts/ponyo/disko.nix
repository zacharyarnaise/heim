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

              settings = {
                allowDiscards = true;
                bypassWorkqueues = true;
              };
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
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
                  "@containers" = {
                    mountpoint = "/persist/containers";
                    mountOptions = ["compress=zstd:1" "noatime" "lazytime"];
                  };
                  "@containers-rootless" = {
                    mountpoint = "/persist/containers-rootless";
                    mountOptions = ["compress=zstd:1" "noatime" "lazytime"];
                  };
                };
              };
            };
          };

          swap = {
            size = "4G";
            content = {
              type = "swap";
              randomEncryption = true;
            };
          };
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = ["defaults" "noatime" "mode=755" "size=4G"];
    };
  };

  fileSystems = {
    "/persist".neededForBoot = true;
    "/var/log".neededForBoot = true;
  };
}
