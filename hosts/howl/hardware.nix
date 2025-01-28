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

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  swapDevices = lib.mkForce [];
}
