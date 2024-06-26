{
  boot = {
    consoleLogLevel = 0;
    kernelParams = [
      "loglevel=3"
      "quiet"
      "rd.udev.log_level=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "vt.global_cursor_default=0"
    ];

    initrd.verbose = false;
    loader.timeout = 0;
  };

  console.earlySetup = false;
}
