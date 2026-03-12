{
  imports = [
    ./powertop.nix
    ./tlp.nix
  ];

  boot.kernel.sysctl = {
    "vm.dirty_writeback_centisecs" = "3000";
  };
}
