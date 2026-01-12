{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestion.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
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

    plugins = [
      {
        name = "zsh-fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "/share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
      {
        name = "zsh-powerlevel10k-config";
        src = ./files;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
    ];

    setOptions = [
      "AUTO_LIST"
      "AUTO_PARAM_SLASH"
      "ALWAYS_TO_END"
      "CORRECT"
      "NO_CORRECT_ALL"
      "NO_NOMATCH"
    ];
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        if [[ -r "''$HOME/.cache/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''$HOME/.cache/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')

      (lib.mkOrder 550 ''
        export ZSH_COMPDUMP=$HOME/.cache/oh-my-zsh/compdump-$ZSH_VERSION
      '')

      (lib.mkOrder 950 ''
        zstyle ':completion:*' accept-exact '*(N)'
        zstyle ':completion:*' complete true
        zstyle ':completion:*' complete-options true
        zstyle ':completion:*' completer _extensions _complete _approximate
        zstyle ':completion:*' group-name '''
        zstyle ':completion:*' insert-tab false
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' list-dirs-first true
        zstyle ':completion:*' list-separator '''
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' menu false
        zstyle ':completion:*' sort false
        zstyle ':completion:*' verbose true
        zstyle ':completion:*' use-cache true
        zstyle ':completion:*:descriptions' format '[%d]'

        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -lAhF -1 --group-directories-first $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -lAhF -1 --group-directories-first $realpath'
        zstyle ':fzf-tab:*' fzf-bindings 'ctrl-a:toggle-all'
        zstyle ':fzf-tab:*' fzf-min-height 100
        zstyle ':fzf-tab:*' fzf-pad 4
        zstyle ':fzf-tab:*' prefix '''
        zstyle ':fzf-tab:*' single-group color header
        zstyle ':fzf-tab:*' switch-group '|' '\'
        zstyle ':fzf-tab:*' use-fzf-default-opts true
      '')
    ];
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
