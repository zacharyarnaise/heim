{
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    plugins = {
      inherit
        (pkgs.yaziPlugins)
        chmod
        diff
        miller
        git
        glow
        jump-to-char
        ouch
        smart-enter
        smart-filter
        sudo
        full-border
        toggle-pane
        mount
        yatline
        yatline-catppuccin
        ;
    };

    settings = {
      manager = {
        ratio = [1 4 3];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "mtime";
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        wrap = "yes";
        tab_size = 2;
        image_delay = 100;
        image_filter = "triangle";
        max_width = 800;
        max_height = 1000;
      };
    };
  };
}
