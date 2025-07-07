{
  boot.initrd = {
    luks.devices.crypted = {
      device = "/dev/disk/by-partuuid/902e0f0f-1cc8-4f5a-ba81-2414b46c9fc5";
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
      options = ["defaults" "noatime" "mode=755" "size=8G"];
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

    "/persist/containers" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@containers" "compress=lzo" "noatime" "lazytime"];
    };
    "/persist/containers-rootless" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@containers-rootless" "compress=lzo" "noatime" "lazytime"];
    };
  };
}
