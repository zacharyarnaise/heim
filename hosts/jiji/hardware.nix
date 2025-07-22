{
  config,
  inputs,
  lib,
  ...
}: let
  flakeSecrets = inputs.secrets.hosts."jiji";
  inherit (config.sops) secrets;
in {
  imports = [
    ./disko.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "virtio_pci"
      "virtio_scsi"
      "sd_mod"
      "sr_mod"
    ];

    loader = {
      systemd-boot.enable = lib.mkForce false;
      grub.enable = true;
    };
  };

  sops.secrets = {
    "storagebox/credentials" = {};
  };
  fileSystems."/storage/sb01" = {
    device = flakeSecrets.storagebox.share;
    fsType = "cifs";
    options = [
      "credentials=${secrets."storagebox/credentials".path}"
      "cache=loose"

      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=1min"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };

  nix.settings.max-jobs = 2;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
