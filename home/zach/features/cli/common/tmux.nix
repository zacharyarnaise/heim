{
  programs.tmux = {
    enable = true;

    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    historyLimit = 10000;
    keyMode = "emacs";
    mouse = true;
    newSession = true;
    prefix = "C-x";
    resizeAmount = 10;
    terminal = "screen-256color";

    extraConfig = ''
      # Increase messages display duration from 750ms to 4s
      set -g display-time 4000
      # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
      set -g status-interval 5
      # Focus events enabled for terminals that support them
      set -g focus-events on
    '';
  };
}
