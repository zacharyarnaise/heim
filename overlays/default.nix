{inputs, ...}: let
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

  additions = final: _: import ../pkgs {pkgs = final;};

  # Modifications to existing packages
  modifications = _final: prev: {
    beets = addPatches prev.beets [
      # Don't send user-agent bc some lyrics providers block it
      (prev.fetchpatch {
        url = "https://github.com/beetbox/beets/commit/095c69a853f6de70f131a1bfc62256e3d2c5cebe.patch";
        hash = "sha256-CsJwQiXiRk3f5NFMuodpsb+lD3u3pbOzEejip5X28Po=";
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
      k3sVersion = "1.35.1-k3s1";
    };

    python313 = prev.python313.override {
      packageOverrides = _: super: {
        picosvg = addPatches super.picosvg [
          # Until https://github.com/NixOS/nixpkgs/pull/493376 hits unstable
          (prev.fetchpatch {
            url = "https://github.com/googlefonts/picosvg/commit/885ee64b75f526e938eb76e09fab7d93e946a355.patch";
            hash = "sha256-fR3FfnEPHwSO1rMtmQEr1pyvByTx8T53FxSpuAKWIjw=";
          })
        ];
      };
    };

    sbctl = prev.sbctl.override {
      databasePath = "/persist/etc/secureboot";
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
