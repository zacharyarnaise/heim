{
  boot.initrd = {
    luks.devices.crypted = {
      device = "/dev/nvme0n1p5";
      allowDiscards = true;
      bypassWorkqueues = true;
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/nixESP";
      fsType = "vfat";
      options = ["defaults" "noexec" "umask=0077"];
    };

    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "noatime" "mode=755" "size=6G"];
    };

    "/persist" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@persist" "compress=lzo" "noatime"];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@nix" "compress=lzo" "noatime" "lazytime" "noacl"];
    };

    "/var/log" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@log" "compress=lzo" "noatime" "lazytime"];
      neededForBoot = true;
    };

    "/var/lib/docker" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@docker" "compress=lzo" "noatime" "lazytime"];
    };
  };
}
