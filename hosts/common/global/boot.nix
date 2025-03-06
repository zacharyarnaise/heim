{lib, ...}: {
  boot = {
    kernelParams = ["hibernate=no"];

    plymouth.enable = false;

    initrd = {
      systemd.strip = true;
      compressor = "lz4";
      compressorArgs = ["-l" "-10" "--favor-decSpeed"];
    };

    loader = {
      timeout = lib.mkDefault 3;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 10;
        consoleMode = "max";
        editor = lib.mkDefault false;
      };
    };
  };
}
