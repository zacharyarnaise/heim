{
  imports = [
    ./global

    ./features/de/common
    ./features/de/hyprland
    ./features/de/apps
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      workspace = "3";
      primary = true;
    }
  ];
}
