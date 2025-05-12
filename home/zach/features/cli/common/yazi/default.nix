{
  config,
  pkgs,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      glow
      miller
      ;
  };

  programs.yazi = {
    enable = true;

    enableZshIntegration = config.programs.zsh.enable;
    initLua = ./init.lua;
    keymap = import ./keymap.nix;

    plugins = {
      inherit
        (pkgs.yaziPlugins)
        chmod
        diff
        miller
        ouch
        glow
        git
        jump-to-char
        smart-filter
        full-border
        yatline
        yatline-catppuccin
        ;
    };

    settings = {
      manager = {
        ratio = [1 3 4];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "custom_mtime";
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

      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];

        prepend_previewers =
          map (ext: {
            name = "*.${ext}";
            run = "miller";
          })
          ["csv" "tsv" "json"]
          ++ map (ext: {
            name = "application/${ext}";
            run = "ouch";
          })
          ["zip" "gzip" "x-tar" "x-compressed-tar" "x-tar+gzip" "x-bzip2" "x-7z-compressed" "x-rar" "x-xz" "xz"]
          ++ [
            {
              name = "*.md";
              run = "glow";
            }
          ];
      };
    };
  };
}
