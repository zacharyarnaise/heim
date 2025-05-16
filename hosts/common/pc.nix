{
  imports = [
    ./global

    ./optional/dconf.nix
    ./optional/docker.nix
    ./optional/greetd.nix
    ./optional/hyprland.nix
    ./optional/xdg-portal.nix
    ./optional/pipewire.nix
    ./optional/yubikey.nix
    ./optional/secureboot.nix
  ];

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };

  boot.kernelParams = ["nowatchdog"];
}
