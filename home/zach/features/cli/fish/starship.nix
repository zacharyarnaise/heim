{lib, ...}: {
  programs.starship = {
    enable = true;
    enableInteractive = true;
    enableTransience = true;

    settings = {
      add_newline = true;
      follow_symlinks = true;
      scan_timeout = 100;
      format = lib.concatStrings [
        "[](#9A348E)"
        "$os"
        "$hostname"
        "[](bg:#DA627D fg:#9A348E)"
        "$directory"
        "[](fg:#DA627D bg:#FCA17D)"
        "$git_branch"
        "$git_status"
        "[▓▒░](fg:#FCA17D bg:#86BBD8)"

        "$git_metrics"
        "$git_commit"
      ];
      right_format = lib.concatStrings [
        "$status"
        "$cmd_duration"

        "$sudo"
        "$direnv"
        "$docker_context"
        "$kubernetes"
        "$golang"
        "$helm"
        "$nix_shell"
        "$python"
        "$rust"
        "$zig"

        "$time"
      ];

      os = {
        disabled = false;
        style = "bg:#9A348E";
        symbols."NixOS" = " ";
      };
      hostname = {
        format = "[$ssh_symbol$hostname ](bg:#9A348E)";
        ssh_only = false;
        ssh_symbol = "󰢹 ";
      };
      directory = {
        format = "[ $path ](bg:#DA627D)";
        truncation_length = 30;
        truncation_symbol = "…/";
      };
      git_branch = {
        format = "[ $symbol $branch ](fg:crust bg:yellow)";
        symbol = "";
        truncation_length = 20;
      };
      git_status = {
        format = "[($all_status$ahead_behind )](fg:crust bg:yellow)";
        ahead = " $count";
        behind = " $count";
        diverged = "  $ahead_count$behind_count";
        untracked = "󰘥 ";
        staged = "[󰐙\($count\)](green)";
        up_to_date = "󰗡 ";
        deleted = "󰮈 ";
        modified = "󰝶 ";
        renamed = "󱖘 ";
        ignore_submodules = true;
      };
      git_commit = {
        format = "[($hash$tag )](fg:black bg:bright-black)";
        tag_disabled = false;
        tag_symbol = " ";
      };
      git_metrics = {
        format = "[ [(+$added)](fg:green bg:bright-black) [(-$deleted)](fg:red bg:bright-black) ](bg:bright-black)";
        disabled = false;
        ignore_submodules = true;
        only_nonzero_diffs = true;
      };

      cmd_duration = {
        format = " [$duration]($style)";
      };
      direnv = {
        disabled = false;
        format = "[$symbol]($style) ";
        symbol = "▼";
      };
      docker_context = {
        symbol = " ";
        only_with_files = true;
      };

      golang = {
        format = "via [$symbol($version )($mod_version )]($style)";
        symbol = "󰟓 ";
      };
      helm = {
        symbol = " ";
      };
      kubernetes = {
        disabled = false;
        symbol = "󱃾 ";
        contexts = [
          {
            context_pattern = "((?!default).)*";
            style = "red bold";
            symbol = "󱈸󱃾 ";
          }
        ];
      };
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        heuristic = true;
        symbol = " ";
      };
      package = {
        disabled = true;
      };
      python = {
        python_binary = "python3";
        symbol = " ";
      };
      rust = {
        symbol = " ";
      };
      status = {
        disabled = false;
        symbol = "✗ ";
        success_style = "green";
        success_symbol = "✓ ";
      };
      sudo = {
        disabled = false;
        symbol = " ";
      };
      time = {
        disabled = false;
        format = "󰥔 [$time]($style)";
        time_format = "%T%.3f";
      };
      zig = {
        symbol = " ";
      };
    };
  };
}
