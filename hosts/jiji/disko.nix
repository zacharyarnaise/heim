{inputs, ...}: {
  imports = [inputs.disko.nixosModules.disko];

  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/sda";

      content = {
        type = "gpt";
        partitions = {
          boot = {
            type = "EF02";
            size = "1M";
            priority = 1;
          };
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

          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
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
                "@swap" = {
                  mountpoint = "/.swapvol";
                  swap.swapfile.size = "8G";
                };
              };
            };
          };
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = ["defaults" "noatime" "mode=755" "size=128M"];
    };
  };

  fileSystems = {
    "/persist".neededForBoot = true;
    "/var/log".neededForBoot = true;
  };
}
