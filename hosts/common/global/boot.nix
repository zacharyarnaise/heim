{
  lib,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = ["hibernate=no"];
    loader.timeout = lib.mkDefault 0;

    initrd = {
      compressor = pkgs: "${pkgs.lz4.out}/bin/lz4";
      compressorArgs = ["-l" "-10" "--favor-decSpeed"];
      systemd.enable = true;
    };
  };
}
