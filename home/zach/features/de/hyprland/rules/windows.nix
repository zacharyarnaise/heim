{
  config,
  lib,
  ...
}: let
  workspaceAvailable = workspace: let
    monitor = lib.findFirst (m: builtins.elem workspace m.workspaces) null config.monitors;
  in
    if monitor == null
    then "false"
    else ''hl.get_monitor("${monitor.name}") ~= nil'';
in {
  # Move Discord and Feishin to external screen, if connected
  wayland.windowManager.hyprland.settings.on = [
    {
      _args = [
        "window.open"
        (lib.generators.mkLuaInline ''
          function(w)
            for _, tag in ipairs(w.tags) do
              if tag == "discord" and ${workspaceAvailable "8"} then
                hl.dispatch(hl.dsp.window.move({ workspace = "8", follow = false, window = w }))
                hl.dispatch(hl.dsp.window.fullscreen({ action = "set", window = w }))
              elseif tag == "feishin" and ${workspaceAvailable "9"} then
                hl.dispatch(hl.dsp.window.move({ workspace = "9", window = w }))
                hl.dispatch(hl.dsp.window.fullscreen({ action = "set", window = w }))
              end
            end
          end'')
      ];
    }
  ];

  wayland.windowManager.hyprland.settings.window_rule = [
    # ---------------------------------- TAGS ----------------------------------
    {
      match = {
        class = "chromium-browser|firefox";
      };
      tag = "browser";
    }
    {
      match = {
        class = "xdg-desktop-portal-gtk";
      };
      tag = "popup";
    }
    {
      match = {
        initial_title = "Open|Progress|Save As|Save File";
      };
      tag = "popup";
    }
    {
      match = {
        float = false;
        workspace = "f[1]";
      };
      tag = "smartgaps";
    }
    {
      match = {
        float = false;
        workspace = "w[tv1]";
      };
      tag = "smartgaps";
    }

    # ------------------------------- Fullscreen -------------------------------
    {
      match = {
        fullscreen = true;
      };
      no_dim = true;
      opaque = true;
    }

    # --------------------------------- Popups ---------------------------------
    {
      match = {
        tag = "popup";
      };
      center = true;
      float = true;
      size = ["monitor_w * 0.3" "monitor_h * 0.3"];
    }

    # ------------------------------- Smart gaps -------------------------------
    {
      match = {
        tag = "smartgaps";
      };
      border_size = 1;
    }
    {
      match = {
        tag = "smartgaps";
      };
      opacity = "${toString config.stylix.opacity.applications} override";
    }

    # --------------------------- Special workspace ---------------------------
    {
      match = {
        workspace = "special:scratchpad";
      };
      border_size = 0;
      float = true;
      max_size = ["monitor_w" "monitor_h * 0.9"];
      move = ["monitor_w * 0.005" "monitor_h * 0.03"];
      no_anim = true;
      no_dim = true;
      opacity = "0.75 override";
      size = ["monitor_w * 0.99" "monitor_h * 0.4"];
    }

    # -------------------------------- Browsers --------------------------------
    {
      match = {
        tag = "browser";
      };
      opacity = "1.0 override 0.95 override";
    }

    # -------------------------------- Discord --------------------------------
    {
      match = {
        class = "vesktop";
        initial_title = "Discord Popout";
      };
      fullscreen = true;
      idle_inhibit = "always";
      no_dim = true;
      opaque = true;
      workspace = "7";
    }
    {
      match = {
        class = "vesktop";
        initial_title = "Discord";
        modal = false;
      };
      no_dim = true;
      no_initial_focus = true;
      opaque = true;
      tag = "discord";
    }

    # -------------------------------- Feishin --------------------------------
    {
      match = {
        class = "feishin";
      };
      opacity = "0.95 override";
      tag = "feishin";
    }

    # -------------------------------- Nautilus --------------------------------
    {
      match = {
        class = "org.gnome.Nautilus";
      };
      float = true;
      opacity = "0.9 override";
      size = ["monitor_w * 0.5" "monitor_h * 0.5"];
    }

    # -------------------------------- Noctalia --------------------------------
    {
      match = {
        class = "dev.noctalia.Noctalia";
        initial_title = "Noctalia Settings";
      };
      center = true;
      float = true;
      size = ["monitor_w * 0.5" "monitor_h * 0.5"];
    }

    # ------------------------------- Qalculate! -------------------------------
    {
      match = {
        class = "io.github.Qalculate.qalculate-qt";
      };
      float = true;
      opacity = "0.9 override";
      pin = true;
      render_unfocused = true;
      size = ["monitor_w * 0.2" "monitor_h * 0.3"];
    }
  ];
}
