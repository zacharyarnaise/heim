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
    hyprland = inputs.nixpkgs-unstable.legacyPackages."${final.system}".hyprland.override {
      enableXWayland = false;
    };
  };
}
