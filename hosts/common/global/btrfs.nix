{
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = ["/nix"];
  };
}
