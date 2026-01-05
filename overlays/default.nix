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

    # https://github.com/NixOS/nixpkgs/pull/476347
    vesktop = prev.vesktop.overrideAttrs (_: {
      # electron builds must be writable
      preBuild =
        prev.lib.optionalString prev.stdenv.hostPlatform.isDarwin ''
          cp -r ${prev.electron.dist}/Electron.app .
          chmod -R u+w Electron.app
        ''
        + prev.lib.optionalString prev.stdenv.hostPlatform.isLinux ''
          cp -r ${prev.electron.dist} electron-dist
          chmod -R u+w electron-dist
        '';

      buildPhase = ''
        runHook preBuild

        pnpm build
        pnpm exec electron-builder \
          --dir \
          -c.asarUnpack="**/*.node" \
          -c.electronDist=${
          if prev.stdenv.hostPlatform.isDarwin
          then "."
          else "electron-dist"
        } \
          -c.electronVersion=${prev.electron.version}

        runHook postBuild
      '';
    });

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
