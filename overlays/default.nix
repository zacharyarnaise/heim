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

  additions = final: prev: {
    base24-schemes = final.base16-schemes.overrideAttrs (oldAttrs: {
      pname = "base24-schemes";
      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/themes/
        install base24/*.yaml $out/share/themes/

        runHook postInstall
      '';
    });
  };

  # Modifications to existing packages
  modifications = _final: prev: {
    base16-schemes = prev.base16-schemes.overrideAttrs (oldAttrs: {
      version = "0-unstable-2026-01-08";
      src = prev.fetchFromGitHub {
        owner = "tinted-theming";
        repo = "schemes";
        rev = "0c25cbcb7bc5e656577f60adf25be5011feabbe5";
        hash = "sha256-kKUjOPC5UKZfWAtI7Drj+wB+zGs17J61kg7FH3j7Et8=";
      };
    });

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

    feishin = prev.feishin.override {
      mpv = prev.mpv-unwrapped;
    };

    # See: https://github.com/k3d-io/k3d/issues/1560
    k3d = prev.k3d.override {
      k3sVersion = "1.33.6-k3s1";
    };

    # ly should read from /etc/login.defs but it doesn't seems to be working
    ly = prev.ly.overrideAttrs (oldAttrs: {
      zigBuildFlags =
        (oldAttrs.zigBuildFlags or [])
        ++ ["-Dfallback_uid_max=29999"];
    });

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
