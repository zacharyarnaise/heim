{
  imports = [
    ./powertop.nix
    ./tlp.nix
    ./upower.nix
  ];

  boot.kernel.sysctl = {
    "vm.dirty_writeback_centisecs" = "3000";
  };
}
