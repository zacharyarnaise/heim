{pkgs, ...}: {
  imports = [
    ./git.nix
    ./golang.nix
    ./gpg.nix
    ./k9s.nix
    ./ssh.nix
    ./vscode.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ansible
      k3d
      tilt
      ;
  };
}
