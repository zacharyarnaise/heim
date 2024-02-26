{
  boot = {
    initrd.systemd.enable = true;
    kernelParams = ["nowatchdog"];

    loader = {
      grub.enable = false;
      timeout = 2;

      systemd-boot = {
        configurationLimit = 10;
        consoleMode = "max";
        editor = false;
        enable = true;
      };
    };

    plymouth.enable = false;
  };

  console.earlySetup = true;
}
