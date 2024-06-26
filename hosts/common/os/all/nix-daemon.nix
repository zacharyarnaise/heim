{
  lib,
  pkgs,
  ...
}: {
  nix = {
    enable = true;
    checkAllErrors = true;
    checkConfig = true;
    package = pkgs.nixVersions.latest;

    # GC runs on a weekly basis, keeping the last three generations
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +3";
      persistent = true;
    };

    optimise = {
      automatic = true;
      dates = ["daily"];
    };

    settings = {
      auto-optimise-store = false;
      allow-import-from-derivation = lib.mkDefault false;
      allowed-users = lib.mkDefault [""]; # Trusted users are always allowed to connect
      trusted-users = ["root" "@wheel"];
      require-sigs = true;
      substituters = [
        "https://nix-config.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      flake-registry = ""; # Disable global flake registry
      max-silent-time = 60;

      system-features = [
        "kvm"
        "big-parallel"
        "nixos-test"
      ];
      experimental-features = [
        "ca-derivations"
        "nix-command"
        "flakes"
      ];
    };
  };
}
