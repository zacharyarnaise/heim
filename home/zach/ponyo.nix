{
  imports = [
    ./global

    ./features/de/common
    ./features/de/hyprland
    ./features/de/apps

    ./features/dev
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1200;
      scale = "1.0";
      workspaces = ["1" "2" "3" "4" "5" "6" "7"];
      primary = true;
    }
  ];

  wayland.windowManager.hyprland.settings.device = [
    {
      name = "syna8020:00-06cb:ce5c-touchpad";
      accel_profile = "adaptive";
      sensitivity = 0.4;
    }
    {
      name = "tpps/2-elan-trackpoint";
      accel_profile = "adaptive";
      sensitivity = 0;
    }
  ];
}
