{config, ...}: {
  programs.ashell = {
    enable = true;
    systemd.enable = true;

    settings = {
      log_level = "error";
      position = "Top";

      workspaces = {
        enable_workspace_filling = true;
        visibility_mode = "MonitorSpecific";
      };
    };
  };
}
