{
  imports = [
    ./global

    ./optional/boot-quiet.nix
    ./optional/dconf.nix
    ./optional/greetd.nix
    ./optional/hyprland.nix
    ./optional/keyring.nix
    ./optional/pipewire.nix
    ./optional/podman.nix
    ./optional/yubikey.nix
    ./optional/secureboot.nix
  ];

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };

  boot.kernelParams = ["nowatchdog"];

  # Use dbus-broker, high performance implementation (already the default in Arch)
  services.dbus.implementation = "broker";
}
