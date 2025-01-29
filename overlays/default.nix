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
    hyprland = inputs.nixpkgs-unstable.hyprland.override (_: {
      enableXWayland = false;
    });
  };
}
