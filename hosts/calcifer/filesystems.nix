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
      options = ["defaults" "noexec" "nosuid" "nodev" "umask=0077"];
    };

    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "noatime" "mode=755" "size=16G"];
    };

    "/persist" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@persist" "compress=zstd:1" "noatime"];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@nix" "compress=zstd:1" "noatime" "lazytime"];
    };

    "/var/log" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@log" "compress=zstd:1" "noatime" "lazytime" "nosuid" "nodev" "noexec"];
      neededForBoot = true;
    };

    "/persist/containers" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@containers" "compress=zstd:1" "noatime" "lazytime"];
    };
    "/persist/containers-rootless" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@containers-rootless" "compress=zstd:1" "noatime" "lazytime"];
    };

    "/.swapvol" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvol=@swap" "noatime"];
    };
  };
}
