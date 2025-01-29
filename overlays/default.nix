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

  modifications = let
    unstable = import inputs.nixpkgs-unstable;
  in
    final: prev: {
      hyprland = unstable.hyprland.override {
        enableXWayland = false;
      };
    };
}
