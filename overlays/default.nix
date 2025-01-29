{inputs, ...}: {
  # Adds pkgs.unstable
  unstable = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config = {
        allowUnfree = true;
      };
    };
  };

  modifications = final: prev: {
    hyprland = import inputs.nixpkgs-unstable.hyprland.override {
      enableXWayland = false;
    };
  };
}
