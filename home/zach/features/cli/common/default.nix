{pkgs, ...}: {
  imports = [
    ./yazi

    ./atuin.nix
    ./bat.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
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

  programs.btop.enable = true;
  programs.thefuck.enable = true;
}
