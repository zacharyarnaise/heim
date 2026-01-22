{
  config,
  lib,
  ...
}: {
  programs.eza = {
    enable = true;
    enableFishIntegration = lib.mkForce false; # Don't want default aliases

    extraOptions = ["--group-directories-first"];
    icons = "auto";
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
