{lib, ...}: {
  boot = {
    kernelParams = ["hibernate=no"];
    blacklistedKernelModules = [
      "btusb"
      "pcspkr"
      "psmouse"
      "snd_hda_codec_hdmi"
      "snd_pcsp"
    ];

    plymouth.enable = false;

    initrd = {
      systemd.strip = true;
      compressor = pkgs: "${pkgs.lz4.out}/bin/lz4";
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
