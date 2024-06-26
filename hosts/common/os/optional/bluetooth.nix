{
  hardware.bluetooth = {
    disabledPlugins = ["sap"];
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        MultiProfile = "single";
        Privacy = "device";
        Experimental = true; # D-Bus experimental interfaces
      };
    };
  };
}
