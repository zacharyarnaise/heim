{config, ...}: {
  programs.atuin = {
    enable = true;

    settings = {
      update_check = false;
      auto_sync = true;
      sync_address = "http://${config.heim.net.services.atuin.ip}:${toString config.heim.net.services.atuin.port}";
      sync_frequency = "15m";
      db_path = "/persist${config.home.homeDirectory}/.atuin.db";
      session_path = "/persist${config.home.homeDirectory}/.atuin-session";

      dialect = "uk";
      style = "auto";
      inline_height = 20;
      prefers_reduced_motion = true;
      search_mode = "daemon-fuzzy";
      filter_mode = "host";
      search_mode_shell_up_key_binding = "daemon-fuzzy";
      filter_mode_shell_up_key_binding = "session";
      workspaces = true;
      keymap_mode = "vim-insert";
      enter_accept = false;
      show_help = false;

      history_filter = [
        "^base64"
        "^clear$"
      ];

      search = {
        frequency_score_multiplier = "0.5";
        recency_score_multiplier = "5.0";
      };
    };

    daemon = {
      enable = true;
      logLevel = "warn";
    };
  };
  home.persistence."/persist" = {
    files = [
      ".local/share/atuin/host_id"
      ".local/share/atuin/key"
      ".local/share/atuin/last_sync_time"
    ];
  };
}
