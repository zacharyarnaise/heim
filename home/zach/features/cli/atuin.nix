{config, ...}: {
  programs.atuin = {
    enable = true;

    settings = {
      update_check = false;
      auto_sync = false;
      sync_address = "";
      db_path = "/persist${config.home.homeDirectory}/.atuin.db";

      dialect = "uk";
      style = "compact";
      inline_height = 20;
      filter_mode = "host";
      filter_mode_shell_up_key_binding = "session";
      keymap_mode = "emacs";
      enter_accept = true;

      history_filter = [
        "^base64"
      ];
    };
  };
}
