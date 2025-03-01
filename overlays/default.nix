{inputs, ...}: {
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
    sudo = prev.sudo.override {
      withInsults = true;
    };
  };
}
