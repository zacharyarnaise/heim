{
  pkgs ? import <nixpkgs> {},
  checks,
  ...
}: {
  default = pkgs.mkShell {
    inherit (checks.pre-commit-check) shellHook;
    buildInputs = checks.pre-commit-check.enabledPackages;

    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = builtins.attrValues {
      inherit
        (pkgs)
        nix
        home-manager
        nh
        pre-commit
        deadnix
        statix
        git
        age
        sops
        ssh-to-age
        sbctl
        ;
    };
  };
}
