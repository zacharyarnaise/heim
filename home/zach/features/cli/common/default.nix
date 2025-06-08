{pkgs, ...}: {
  imports = [
    ./yazi

    ./atuin.nix
    ./bat.nix
    ./btop.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./nix-index.nix
    ./pay-respects.nix
    ./ssh.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      bc
      fd
      file
      ncdu
      ouch
      jq
      sysz
      wget
      ;
  };
}
