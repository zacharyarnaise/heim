{lib, ...}: {
  programs.ashell = {
    enable = true;
    systemd.enable = true;

    settings = {
      log_level = "error";
      outputs = "Active";
      position = "Top";

      appearance = {
        opacity = lib.mkForce 0.4;
      };
      modules = {
        left = ["SystemInfo" "MediaPlayer"];
        center = ["Workspaces"];
        right = ["Tray" ["Privacy" "Settings" "Clock"]];
      };

      system_info = {
        indicators = ["Cpu" "Memory" "Temperature"];
      };

      workspaces = {
        enable_workspace_filling = true;
        max_workspaces = 7;
        visibility_mode = "MonitorSpecific";
      };
    };
  };
}
