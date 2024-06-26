{
  disko.devices = {
    disk = {
      nvme0n1 = {
        device = "/dev/nvme0n1";
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
                mountOptions = ["defaults" "noauto" "noexec"];
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
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["compress=lzo" "noatime"];
                    };
                    "/persist" = {
                      mountOptions = ["compress=lzo" "noatime"];
                    };
                    "/nix" = {
                      mountOptions = [
                        "compress=lzo"
                        "noatime"
                        "lazytime"
                        "noacl"
                      ];
                    };
                    "/var/log" = {
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
  };

  fileSystems = {
    "/persist".neededForBoot = true;
    "/var/log".neededForBoot = true;
  };
}
