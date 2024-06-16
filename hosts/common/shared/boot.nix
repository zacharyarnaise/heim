{lib, ...}: {
  boot = {
    initrd.systemd.enable = true;
    kernelParams = ["nowatchdog"];

    loader = {
      timeout = 2;

      systemd-boot = {
        configurationLimit = 10;
        consoleMode = "max";
        editor = false;
      };
    };

    plymouth.enable = false;
  };

  console = {
    earlySetup = lib.mkDefault true;
    useXkbConfig = true;
  };
}
