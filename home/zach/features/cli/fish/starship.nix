{lib, ...}: {
  programs.starship = {
    enable = true;
    enableInteractive = true;
    enableTransience = true;

    settings = {
      add_newline = true;
      fill.symbol = " ";
      follow_symlinks = true;
      scan_timeout = 100;
      format = lib.concatStrings [
        "[░▒▓](white)"
        "$os"
        "$hostname"
        "[](fg:white bg:#769ff0)"
        "$directory"
        "[](fg:#769ff0 bg:#394260)"
        "$git_branch"
        "$git_status"
        "[](fg:#394260 bg:#212736)"
        "$git_metrics"
        "$git_commit"
        "[](#212736) "
        "( $status)"
        "($cmd_duration)"

        "$fill"

        "[](#394260)"
        "$kubernetes"
        "[](fg:#769ff0 bg:#394260)"
        "$golang"
        "$helm"
        "$nix_shell"
        "$python"
        "$rust"
        "$zig"
        "[](fg:white bg:#769ff0)"
        "$direnv"
        "$time"
        "[▓▒░](white)"

        "$line_break"
        "$character"
      ];

      character = {
        error_symbol = "[❯](bold red)";
        success_symbol = "[❯](bold green)";
      };
      os = {
        disabled = false;
        style = "fg:black bg:white";
        symbols."NixOS" = "   ";
      };
      hostname = {
        format = "[$ssh_symbol$hostname ](fg:black bg:white)";
        ssh_only = false;
        ssh_symbol = "󰢹 ";
      };
      directory = {
        format = "[ $path ](bold fg:#f0f0f0 bg:#769ff0)";
        truncation_length = 30;
        truncation_symbol = "…/";
        substitutions = {
          "Code" = "󰈮 ";
          "Documents" = "󰈙 ";
          "Downloads" = "󰥥 ";
          "Pictures" = "󰈟 ";
          "Videos" = "󰈫 ";
        };
      };
      git_branch = {
        format = "[$symbol $branch ](fg:#769ff0 bg:#394260)";
        symbol = " ";
        truncation_length = 20;
      };
      git_status = {
        format = "[($ahead_behind )](fg:#769ff0 bg:#394260)";
        ahead = "[$count](fg:purple bg:#394260)";
        behind = "[$count](fg:red bg:#394260)";
        diverged = "[$ahead_count](fg:purple bg:#394260)[$behind_count](fg:red bg:#394260)";
        up_to_date = "[󰗡](fg:green bg:#394260)";
        ignore_submodules = true;
      };
      git_commit = {
        format = "[($hash$tag )](fg:#769ff0 bg:#212736)";
        tag_disabled = false;
        tag_symbol = " ";
      };
      git_metrics = {
        format = "[[( +$added)](fg:green bg:#212736) [(-$deleted )](fg:red bg:#212736)](bg:#212736)";
        disabled = false;
        ignore_submodules = true;
        only_nonzero_diffs = true;
      };

      direnv = {
        disabled = false;
        format = "[($symbol )](fg:red bg:white)";
        symbol = " ▼";
      };
      golang = {
        format = "[$symbol($version )($mod_version )](fg:#f0f0f0 bg:#769ff0)";
        symbol = " 󰟓 ";
      };
      helm = {
        format = "[$symbol($version )](fg:#f0f0f0 bg:#769ff0)";
        symbol = "  ";
      };
      kubernetes = {
        disabled = false;
        format = "[($symbol$context )]($style)";
        style = "fg:#769ff0 bg:#394260";
        symbol = " 󱃾 ";
        contexts = [
          {
            context_pattern = "admin@.*";
            style = "fg:red bg:#394260";
            symbol = " 󱈸󱃾 ";
          }
        ];
      };
      nix_shell = {
        format = "[($symbol$state )](fg:#f0f0f0 bg:#769ff0)";
        heuristic = true;
        symbol = "  ";
      };
      package.disabled = true;
      python = {
        format = "[$symbol$pyenv_prefix($version )(\($virtualenv\) )](fg:#f0f0f0 bg:#769ff0)";
        python_binary = "python3";
        symbol = "  ";
      };
      rust = {
        format = "[$symbol($version )](fg:#f0f0f0 bg:#769ff0)";
        symbol = "  ";
      };
      status = {
        disabled = false;
        symbol = "✗ ";
        success_style = "bold green";
        success_symbol = "✓ ";
      };
      time = {
        disabled = false;
        format = "[  $time](fg:black bg:white)";
        time_format = "%T";
      };
      zig = {
        format = "[$symbol($version )](fg:#f0f0f0 bg:#769ff0)";
        symbol = "  ";
      };
    };
  };
}
