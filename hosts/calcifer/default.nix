{inputs, ...}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel-cpu-only
    common-gpu-amd
    common-pc-ssd

    ../common/pc.nix

    ../common/optional/bluetooth.nix
    ../common/optional/boot-efi.nix
  ];

  networking = {
    hostName = "calcifer";
  };

  nix.settings.max-jobs = 20; # == logical cores count
}
