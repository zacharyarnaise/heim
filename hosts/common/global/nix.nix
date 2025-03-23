{lib, ...}: {
  nix = {
    # https://github.com/NixOS/nix/issues/2982
    channel.enable = false;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
      persistent = true;
    };

    settings = {
      accept-flake-config = true;
      auto-optimise-store = true;
      allow-import-from-derivation = lib.mkDefault true;
      allowed-users = lib.mkDefault [""]; # Trusted users are always allowed to connect
      trusted-users = lib.mkForce ["@wheel"];
      extra-substituters = lib.mkAfter [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
