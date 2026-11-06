{
  boot = {
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
  };
}
