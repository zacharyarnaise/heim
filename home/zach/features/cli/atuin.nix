{
  programs.atuin = {
    enable = true;

    settings = {
      auto_sync = false;
      sync_address = "";
      update_check = false;

      style = "auto";
      inline_height = 20;
      filter_mode = "host";
      filter_mode_shell_up_key_binding = "session";
      keymap_mode = "vim-insert";
      enter_accept = true;

      history_filter = [
        "^base64"
      ];
    };
  };
}
