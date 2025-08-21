{
  config,
  inputs,
  lib,
  ...
}: let
  flakeSecrets = inputs.secrets.hosts."kamaji";
  inherit (config.sops) secrets;
in {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./disko.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "sd_mod"
    ];
  };

  hardware.graphics.enable = true;

  sops.secrets = {
    "storagebox/credentials" = {};
  };
  fileSystems."/storage/media/library/music" = {
    device = flakeSecrets.storagebox.share;
    fsType = "cifs";
    options = [
      "credentials=${secrets."storagebox/credentials".path}"
      "cache=loose"
      "iocharset=utf8"
      "vers=3.0"

      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=1min"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"

      "uid=root"
      "gid=media"
    ];
  };

  nix.settings.max-jobs = 8;
  swapDevices = lib.mkForce [];
  powerManagement.cpuFreqGovernor = "ondemand";
}
