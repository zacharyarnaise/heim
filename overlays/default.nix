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
    gopass = prev.gopass.override {
      xclip = null;
      passAlias = true;
    };

    # See: https://github.com/k3d-io/k3d/issues/1560
    k3d = prev.k3d.override {
      k3sVersion = "1.33.4-k3s1";
    };

    lidarr = let
      version = "2.14.3.4791";
    in
      prev.lidarr.overrideAttrs (_: {
        inherit version;
        src = prev.fetchurl {
          url = "https://github.com/Lidarr/Lidarr/releases/download/v${version}/Lidarr.develop.${version}.linux-core-x64.tar.gz";
          hash = "sha256-A7khU6ayTyX7JkeOHsojEmtfqIfWn+c+UxTagyS3J1A=";
        };
      });

    sbctl =
      prev.sbctl.override {databasePath = "/persist/etc/secureboot";};

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
