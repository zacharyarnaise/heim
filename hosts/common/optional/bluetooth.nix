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
      };
    };
  };
}
