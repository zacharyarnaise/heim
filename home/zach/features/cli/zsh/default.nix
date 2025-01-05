{pkgs, ...}: {
  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets"];
    };
    history = {
      # History is managed by atuin
      size = 0;
      save = 0;
      share = false;
    };

    shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";

      ns = "nix-shell";
    };

    plugins = with pkgs; [
      {
        name = "zsh-powerlevel10k-config";
        src = ./files;
        file = "p10k.zsh";
      }
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
      if [[ -r "''$HOME/.cache/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''$HOME/.cache/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    initExtraBeforeCompInit = ''
      export ZSH_COMPDUMP=$HOME/.cache/oh-my-zsh/compdump-$ZSH_VERSION
    '';

    initExtra = ''
      setopt hist_reduce_blanks
      setopt auto_list
      setopt NO_HIST_SAVE_BY_COPY
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
}
