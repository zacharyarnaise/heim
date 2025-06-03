{config, ...}: {
  programs.pay-respects = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
  };

  programs.nix-index.enableZshIntegration = false; # pay-respects will handle this
}
