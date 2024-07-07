{pkgs, ...}: {
  programs.zsh = {
    enable = true;

    autosuggestions = {
      enable = true;
      async = true;
    };
    enableCompletion = true;
    enableGlobalCompInit = true;
    histSize = 5000;
    syntaxHighlighting.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [pkgs.zsh];
}
