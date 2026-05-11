{secrets, ...}: {
  nightModeEnabled = true;
  nightModeTemperature = 3500;
  nightModeHighTemperature = 6500;
  nightModeAutoEnabled = true;
  nightModeAutoMode = "location";
  nightModeStartHour = 19;
  nightModeStartMinute = 0;
  nightModeEndHour = 7;
  nightModeEndMinute = 0;
  latitude = secrets.users.zach.coordinates.lat;
  longitude = secrets.users.zach.coordinates.lng;
  nightModeUseIPLocation = false;
  themeModeAutoEnabled = false;
  weatherCoordinates = "${secrets.users.zach.coordinates.lat},${secrets.users.zach.coordinates.lng}";
  weatherHourlyDetailed = true;
  hiddenApps = [
    "foot-server"
    "foot"
    "khal"
    "kvantummanager"
    "qt5ct"
    "qt6ct"
    "rofi-theme-selector"
    "rofi"
  ];
  appOverrides = {
    "footclient".name = "Foot";
    "nvim".name = "Neovim";
    "io.github.Qalculate.qalculate-qt".name = "Qalculate!";
  };
  searchAppActions = false;
  hiddenOutputDeviceNames = [
    "alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink"
    "alsa_output.usb-Generic_USB_Audio-00.HiFi__SPDIF__sink"
    "alsa_output.usb-Generic_USB_Audio-00.HiFi__Headphones__sink"
  ];
  hiddenInputDeviceNames = [
    "alsa_input.usb-Generic_USB_Audio-00.HiFi__Mic__source"
    "alsa_input.usb-Generic_USB_Audio-00.HiFi__Line__source"
  ];
  appDrawerLastMode = "apps";
  configVersion = 3;
}
