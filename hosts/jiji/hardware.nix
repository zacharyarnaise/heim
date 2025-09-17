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
  fileSystems = let
    mountOptions = [
      "credentials=${secrets."storagebox/credentials".path}"
      "cache=loose"
      "iocharset=utf8"
      "vers=3.0"

      "_netdev"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=2min"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  in {
    "/storage/sb01/music" = {
      device = flakeSecrets.storagebox.share + "/music";
      fsType = "cifs";
      options =
        mountOptions
        ++ ["uid=navidrome" "gid=media" "dir_mode=0775" "file_mode=0664"];
    };
  };

  nix.settings.max-jobs = 2;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
