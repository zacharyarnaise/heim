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
      height = 1080;
      workspaces = ["1" "2" "3" "4" "5" "6"];
      primary = true;
    }
  ];

  wayland.windowManager.hyprland.settings.device = [
    {
      name = "synps/2-synaptics-touchpad";
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
