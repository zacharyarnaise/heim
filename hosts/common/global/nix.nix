{lib, ...}: {
  nix = {
    # https://github.com/NixOS/nix/issues/2982
    channel.enable = false;

    gc = {
      automatic = true;
      dates = "Sat *-*-* 00:00:00";
      options = "--delete-older-than 7d";
      persistent = true;
    };
    optimise = {
      automatic = true;
      dates = ["Sat *-*-* 00:00:00"];
      persistent = true;
    };

    settings = {
      accept-flake-config = true;
      auto-optimise-store = false;
      allow-import-from-derivation = lib.mkDefault true;
      allowed-users = lib.mkDefault [""]; # Trusted users are always allowed to connect
      trusted-users = lib.mkForce ["@wheel"];
      extra-substituters = lib.mkAfter [
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];

      connect-timeout = 5;
      log-lines = 25;
      max-silent-time = 600;
      warn-dirty = false;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
      system-features = [
        "kvm"
        "big-parallel"
        "nixos-test"
      ];
    };
  };
}
