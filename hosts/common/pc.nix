{
  imports = [
    ./global

    ./optional/boot/lanzaboote.nix
    ./optional/boot/quiet.nix
    ./optional/dconf.nix
    ./optional/display-manager.nix
    ./optional/keyring.nix
    ./optional/pipewire.nix
    ./optional/podman.nix
    ./optional/yubikey.nix
  ];

  boot.kernelParams = ["nowatchdog"];

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };

  # Use dbus-broker, high performance implementation (already the default in Arch)
  services.dbus.implementation = "broker";
}
