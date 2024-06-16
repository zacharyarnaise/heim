{inputs, ...}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-gpu-amd
    common-pc-laptop-ssd

    ../common/pc.nix

    ../common/optional/bluetooth.nix
    ../common/optional/boot-efi.nix
    ../common/optional/boot-quiet.nix
    ../common/optional/powertop.nix
  ];

  # Improve battery life by running full tickless on the last 4 cores
  boot.kernelParams = ["nohz_full=4-7"];

  networking = {
    hostName = "laptop-gb";
  };

  nix.settings.max-jobs = 8; # == logical cores count
}
