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
  wayland.windowManager.hyprland.settings = {
    workspace_rule =
      [
        # ----------------------------- Smart gaps -----------------------------
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

        # --------------------------- Master layout ---------------------------
        {
          workspace = "2";
          layout = "master";
        }
        {
          workspace = "3";
          layout = "master";
        }
      ]
      # ---------------------- Bind workspaces to monitors --------------------
      ++ builtins.concatLists (map (m:
        lib.lists.imap0 (
          i: workspace: mkMonitorRule i m workspace
        )
        m.workspaces)
      config.monitors);

    # ------------------------------ Scratchpad ------------------------------
    on = [
      {
        _args = [
          "workspace.created"
          (lib.generators.mkLuaInline ''
            function(ws)
              if ws.name == "special:scratchpad" and ws.is_empty then
                hl.exec_cmd("foot", { workspace = "special:scratchpad" })
              end
            end'')
        ];
      }
    ];
  };
}
