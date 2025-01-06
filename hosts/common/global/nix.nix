{
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nixVersions.latest;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
      persistent = true;
    };

    settings = {
      accept-flake-config = true;
      auto-optimise-store = true;
      allow-import-from-derivation = lib.mkDefault false;
      allowed-users = lib.mkDefault [""]; # Trusted users are always allowed to connect
      trusted-users = lib.mkForce ["@wheel"];
      substituters = [
        "https://nix-config.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      connect-timeout = 5;
      log-lines = 25;
      max-silent-time = 300;
      warn-dirty = false;

      system-features = [
        "kvm"
        "big-parallel"
        "nixos-test"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
