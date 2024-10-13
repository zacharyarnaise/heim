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
      options = "--delete-older-than 14d";
      persistent = true;
    };

    optimise = {
      automatic = true;
      dates = ["daily"];
    };

    settings = {
      auto-optimise-store = true;
      allow-import-from-derivation = lib.mkDefault false;
      allowed-users = lib.mkDefault [""]; # Trusted users are always allowed to connect
      trusted-users = lib.mkForce ["root" "@wheel"];
      require-sigs = true;
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
      max-silent-time = 60;
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
