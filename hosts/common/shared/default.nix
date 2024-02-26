# Configuration shared between all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager

      ./boot.nix
      ./nix-daemon.nix
      ./resolved.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  hardware = {
    enableAllFirmware = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  time.timeZone = "Europe/Paris";
}
