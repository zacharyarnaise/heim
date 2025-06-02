{config, ...}: {
  programs.pay-respects = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
  };
}
