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
      wget
      p7zip
      unzip
      zip
      ;
  };

  programs.btop.enable = true;
  programs.thefuck.enable = true;
}
