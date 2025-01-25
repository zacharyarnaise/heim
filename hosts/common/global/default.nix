{
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./home-manager.nix

      ./boot.nix
      ./hardening.nix
      ./locale.nix
      ./networking.nix
      ./nix.nix
      ./openssh.nix
      ./secrets.nix
      ./userborn.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    coreutils
    pciutils
  ];

  programs.nh = {
    enable = true;
  };

  hardware.enableAllFirmware = true;
  users.mutableUsers = false;

  # Disable unused stuff
  documentation.doc.enable = false;
  documentation.info.enable = false;
  services.speechd.enable = false;
}
