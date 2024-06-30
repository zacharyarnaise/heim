{
  boot.initrd = {
    luks.devices.crypted = {
      device = "/dev/nvme0n1p2";
      allowDiscards = true;
      bypassWorkqueues = true;
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
      options = ["defaults" "noexec"];
    };

    "/" = {
      device = "/dev/disk/by-label/crypted";
      fsType = "btrfs";
      options = ["subvol=root" "compress=lzo" "noatime"];
    };

    "/persist" = {
      device = "/dev/disk/by-label/crypted";
      fsType = "btrfs";
      options = ["subvol=persist" "compress=lzo" "noatime"];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/disk/by-label/crypted";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=lzo" "noatime" "lazytime" "noacl"];
    };

    "/var/log" = {
      device = "/dev/disk/by-label/crypted";
      fsType = "btrfs";
      options = ["subvol=log" "compress=lzo" "noatime" "lazytime"];
      neededForBoot = true;
    };
  };
}
