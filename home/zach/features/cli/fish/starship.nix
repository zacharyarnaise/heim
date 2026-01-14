{lib, ...}: {
  programs.starship = {
    enable = true;
    enableInteractive = true;
    enableTransience = true;

    settings = {
      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };

      add_newline = true;
      follow_symlinks = true;
      scan_timeout = 100;
      palette = lib.mkForce "catppuccin_mocha";
      format = lib.concatStrings [
        "[](red)"
        "$os"
        "$hostname"
        "[](bg:peach fg:red)"
        "$directory"
        "[](bg:yellow fg:peach)"
        "$git_branch"
        "$git_status"
        "[](bg:green fg:yellow)"
        "$git_commit"
        "$git_metrics"
        "[ ](fg:yellow)"
        "$line_break"
        "$character"
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
        style = "bg:red fg:crust";
        symbols."NixOS" = " ";
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "󰢹 ";
        format = "[$ssh_symbol$hostname]($style) ";
        style = "bg:red fg:crust";
      };

      cmd_duration = {
        format = " [$duration]($style)";
      };
      directory = {
        read_only = " 󰌾";
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
      git_branch = {
        symbol = " ";
        truncation_length = 4;
      };
      git_commit = {
        tag_disabled = false;
        tag_symbol = " ";
      };
      git_metrics = {
        disabled = false;
        ignore_submodules = true;
        only_nonzero_diffs = true;
      };
      git_status = {
        ahead = "$count";
        behind = "$count";
        diverged = " $ahead_count$behind_count";
        untracked = "󰘥";
        staged = "[󰐙\($count\)](green)";
        up_to_date = "󰗡";
        deleted = "󰮈";
        modified = "󰝶";
        renamed = "󱖘";
        ignore_submodules = true;
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
