# This file should be included when using hm standalone
{
  lib,
  pkgs,
  outputs,
  ...
}: {
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      extra-substituters = lib.mkAfter [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      connect-timeout = 5;
      log-lines = 25;
      max-silent-time = 300;
      warn-dirty = false;
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
