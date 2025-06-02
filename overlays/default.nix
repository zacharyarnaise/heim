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

    sbctl =
      prev.sbctl.override {databasePath = "/persist/etc/secureboot";};

    waybar = addPatches prev.waybar [
      ./waybar_mpris_title_clean.diff
    ];

    yubikey-agent = prev.yubikey-agent.overrideAttrs (oldAttrs: {
      patches =
        (oldAttrs.patches or [])
        ++ [
          ./yubikey-agent_deps_update.diff
          ./yubikey-agent_ed25519.diff
        ];
      vendorHash = "sha256-lTBDgmG4vGiu0fW8/hdUOBsNiVQcC6nh+10MReFqA7M=";
    });
    yubikey-touch-detector = addPatches prev.yubikey-touch-detector [
      ./yubikey-touch-detector_notify.diff
    ];
  };
}
