{outputs, ...}: {
  imports =
    [
      ./home-manager.nix

      ./boot.nix
      ./locale.nix
      ./nix.nix
      ./openssh.nix
      ./secrets.nix
      ./zsh.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  hardware.enableAllFirmware = true;
  users.mutableUsers = false;

  # Disable unused stuff
  documentation.doc.enable = false;
  documentation.info.enable = false;
  services.speechd.enable = false;
}
