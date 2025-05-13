{pkgs, ...}: {
  imports = [
    ./git.nix
    ./golang.nix
    ./gpg.nix
    ./k8s.nix
    ./ssh.nix
    ./vscode.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ansible
      tilt
      ;
  };
}
