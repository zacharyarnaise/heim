{
  imports = [
    ./global

    ./optional/dconf.nix
    ./optional/greetd.nix
    ./optional/hyprland.nix
    ./optional/xdg-portal.nix
    ./optional/pipewire.nix
    ./optional/impermanence.nix
  ];

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };

  boot.kernelParams = ["nowatchdog"];
}
