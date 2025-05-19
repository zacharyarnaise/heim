{pkgs, ...}: {
  imports = [
    ./nixvim

    ./direnv.nix
    ./git.nix
    ./golang.nix
    ./gpg.nix
    ./k8s.nix
    ./nix.nix
    ./ssh.nix
    ./tilt.nix
    ./vscode.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ansible
      ;
  };
}
