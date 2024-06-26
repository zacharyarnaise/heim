{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;

      autosuggestions = {
        enable = true;
        async = true;
      };
      enableCompletion = true;
      enableGlobalCompInit = true;
      histSize = 10000;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
        ];
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [pkgs.zsh];
}
