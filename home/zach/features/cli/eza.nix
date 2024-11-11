{
  config,
  lib,
  ...
}: {
  programs.eza = {
    enable = true;

    icons = "always";
    git = true;
  };

  programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
    l = "eza -lah";
    la = "eza -lah";
    ll = "eza -lh";
    ls = "eza";
    lsa = "eza -lah";
  };
}
