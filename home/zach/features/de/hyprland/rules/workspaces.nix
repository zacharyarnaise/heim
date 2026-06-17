{
  config,
  lib,
  ...
}: let
  mkMonitorRule = index: monitor: workspace:
    {
      inherit workspace;
      monitor = monitor.name;
    }
    // (
      if index == 0
      then {
        default = true;
        persistent = true;
      }
      else {}
    );
in {
  wayland.windowManager.hyprland.settings.workspace_rule =
    [
      # ---- Smart gaps ----
      {
        workspace = "f[1]s[false]";
        gaps_in = 0;
        gaps_out = 2;
      }
      {
        workspace = "w[tv1]s[false]";
        gaps_in = 0;
        gaps_out = 2;
      }
    ]
    # ---- Bind workspaces to monitors ----
    ++ builtins.concatLists (map (m:
      lib.lists.imap0 (
        i: workspace: mkMonitorRule i m workspace
      )
      m.workspaces)
    config.monitors);
}
