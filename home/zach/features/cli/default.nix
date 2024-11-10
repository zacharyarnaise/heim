{pkgs, ...}: {
  imports = [
    ./zsh

    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
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
