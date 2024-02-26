{
  lib,
  pkgs,
  ...
}: {
  nix = {
    checkAllErrors = true;
    checkConfig = true;
    enable = true;
    package = pkgs.nixVersions.unstable;

    # Garbage collection runs on a weekly basis, keeping the last two generations
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +2";
      persistent = true;
    };

    optimise = {
      automatic = true;
      dates = "daily";
    };

    settings = {
      auto-optimise-store = false;
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
      experimental-features = [
        "nix-command"
        "flakes"
        "repl-flake"
      ];
      flake-registry = ""; # Disable global flake registry
      max-silent-time = 60; # 1 minute
      system-features = ["kvm" "big-parallel" "nixos-test"];
    };
  };
}
