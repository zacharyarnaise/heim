{pkgs, ...}: {
  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets"];
    };
    history = {
      expireDuplicatesFirst = true;
      extended = true;
    };

    shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";

      ns = "nix-shell";
    };

    plugins = with pkgs; [
      {
        name = "zsh-powerlevel10k";
        src = zsh-powerlevel10k;
        file = "/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-you-should-use";
        src = zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
    ];

    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    initExtraBeforeCompInit = ''
      ZSH_COMPDUMP=''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump-$ZSH_VERSION
    '';

    initExtra = ''
      setopt hist_reduce_blanks
      setopt auto_list
      setopt auto_menu
    '';
  };

  programs.zsh.oh-my-zsh = {
    enable = true;

    extraConfig = ''
      zstyle ':omz:update' mode disabled
      zstyle ':omz:update' frequency 0

      COMPLETION_WAITING_DOTS="true"
      DISABLE_UNTRACKED_FILES_DIRTY="true"
    '';
    plugins = [
      "sudo"
    ];
  };

  # required for completion
  environment.pathsToLink = ["/share/zsh"];
}
