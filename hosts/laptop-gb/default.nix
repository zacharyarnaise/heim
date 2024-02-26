# Work laptop
{inputs, ...}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-gpu-amd
    common-pc-laptop-ssd

    ../common/home-pc.nix

    ../common/optional/bluetooth.nix
    ../common/optional/boot-efi.nix
    ../common/optional/boot-quiet.nix
    ../common/optional/powertop.nix
  ];

  networking = {
    hostName = "laptop-gb";
  };

  nix.settings.max-jobs = 8; # == logical cores count
}
