{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = builtins.attrValues {
      inherit
        (pkgs)
        nix
        home-manager
        deadnix
        stylix
        git
        age
        sops
        ssh-to-age
        sbctl
        ;
    };
  };
}
