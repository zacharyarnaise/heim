{inputs, ...}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  # Adds pkgs.stable
  stable = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final.stdenv.hostPlatform) system;
      config = {
        allowUnfree = true;
      };
    };
  };

  additions = final: _: import ../pkgs {pkgs = final;};

  # Modifications to existing packages
  modifications = _final: prev: {
    beets = addPatches prev.beets [
      # Don't send user-agent bc some lyrics providers block it
      (prev.fetchpatch {
        url = "https://github.com/snejus/beets/commit/2d6c6c188329093c4b78e42a2d0073763c2f9053.patch";
        hash = "sha256-gS1NXX0un1RXgDz+Z5HRv4Pq1sM5TjdpY5HJIe8Y6RY=";
      })
    ];

    gopass = prev.gopass.override {
      xclip = null;
      passAlias = true;
    };

    fish = prev.fish.overrideAttrs (_: {
      postBuild = ''
        rm /build/source/share/functions/cdh.fish
      '';
    });

    # See: https://github.com/k3d-io/k3d/issues/1560
    k3d = prev.k3d.override {
      k3sVersion = "1.35.2-k3s1";
    };

    waybar = addPatches prev.waybar [
      ./waybar_wireplumber_notfound.diff
    ];

    wezterm = addPatches prev.wezterm [
      ./wezterm-frac_scaling_fix.diff
    ];

    yubikey-touch-detector = addPatches prev.yubikey-touch-detector [
      ./yubikey-touch-detector_notify.diff
    ];
  };
}
