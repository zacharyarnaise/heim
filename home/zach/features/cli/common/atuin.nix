{
  config,
  inputs,
  ...
}: let
  # TODO: declare this somewhere else so we avoid referencing the host directly
  syncAddress =
    if config.services.atuin.enable or false
    then "http://127.0.0.1:8888"
    else "http://${inputs.secrets.hosts."jiji".inet}:8888";
in {
  programs.atuin = {
    enable = true;

    settings = {
      update_check = false;
      auto_sync = true;
      sync_address = syncAddress;
      sync_frequency = "15m";
      db_path = "/persist${config.home.homeDirectory}/.atuin.db";
      session_path = "/persist${config.home.homeDirectory}/.atuin-session";

      dialect = "uk";
      style = "auto";
      inline_height = 20;
      prefers_reduced_motion = true;
      search_mode = "skim";
      filter_mode = "host";
      search_mode_shell_up_key_binding = "skim";
      filter_mode_shell_up_key_binding = "session";
      workspaces = true;
      keymap_mode = "emacs";
      enter_accept = false;
      show_help = false;

      history_filter = [
        "^base64"
        "clear"
      ];
    };

    daemon = {
      enable = true;
      logLevel = "warn";
    };
  };
}
