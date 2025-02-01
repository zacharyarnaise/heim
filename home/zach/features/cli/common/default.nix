{pkgs, ...}: {
  imports = [
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

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      bc
      fd
      file
      ncdu
      jq
      sysz
      thefuck
      wget
      p7zip
      unzip
      zip
      ;
  };

  prorgams.btop.enable = true;
}
