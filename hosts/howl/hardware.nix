{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-5
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "usbhid"
    ];
  };

  nix.settings.max-jobs = 4;

  swapDevices = lib.mkForce [];
}
