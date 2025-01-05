{pkgs, ...}: {
  imports = [
    ./zsh

    ./atuin.nix
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    bc
    btop
    coreutils
    fd
    file
    ncdu
    jq
    wget

    p7zip
    unzip
    zip
  ];
}
