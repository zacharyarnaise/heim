{
  inputs,
  outputs,
  lib,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./boot.nix
      ./locale.nix
      ./nix.nix
      ./openssh.nix
      ./security.nix
      ./userborn.nix
      ./zsh.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {inherit inputs outputs;};
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  programs.nh = {
    enable = true;
  };

  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    nixos.enable = lib.mkForce false;
    info.enable = false;
  };

  hardware.enableAllFirmware = true;
  users.mutableUsers = false;
}
