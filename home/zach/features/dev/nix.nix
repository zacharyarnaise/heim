{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      alejandra
      nil
      nix-tree
      ;
  };

  programs.nh = {
    enable = true;

    flake = "$HOME/Code/Nix/heim";
  };

  programs.zsh.dirHashes = {
    heim = "$HOME/Code/Nix/heim";
  };
}
