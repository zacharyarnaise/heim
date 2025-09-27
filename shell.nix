{pkgs ? import <nixpkgs> {}, ...}:
pkgs.mkShell {
  NIX_CONFIG = "extra-experimental-features = nix-command flakes";
  nativeBuildInputs = builtins.attrValues {
    inherit
      (pkgs)
      nix
      home-manager
      nh
      deadnix
      statix
      git
      age
      sops
      ssh-to-age
      sbctl
      ;
  };
}
