{
  inputs,
  lib,
  ...
}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  # Adds pkgs.stable
  stable = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config = {
        allowUnfree = true;
      };
    };
  };

  # Modifications to existing packages
  modifications = _final: prev: {
    sudo =
      prev.sudo.override {withInsults = true;};

    yubikey-agent = prev.yubikey-agent.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ [./yubikey-agent_deps_update.diff];
      vendorHash = lib.fakeHash;
    });
  };
}
