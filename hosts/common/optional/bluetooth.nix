{
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/bluetooth"
    ];
  };

  hardware.bluetooth = {
    disabledPlugins = ["sap"];
    enable = true;
    powerOnBoot = false;

    settings = {
      General = {
        MultiProfile = "multiple";
        Privacy = "device";
        # D-Bus experimental interfaces
        Experimental = true;
        # Kernel experimental features
        # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e = BlueZ experimental ISO socket
        KernelExperimental = "6fbaf188-05e0-496a-9885-d6ddfdb4e03e";
      };
    };
  };
}
