{
  wayland.windowManager.hyprland.settings = {
    curve = [
      {
        _args = [
          "easeInOutQuad"
          {
            type = "bezier";
            points = [[0.45 0] [0.55 1]];
          }
        ];
      }
      {
        _args = [
          "easeOutBack"
          {
            type = "bezier";
            points = [[0.4 1.5] [0.65 1]];
          }
        ];
      }
      {
        _args = [
          "easeOutExpo"
          {
            type = "bezier";
            points = [[0.16 1] [0.3 1]];
          }
        ];
      }
      {
        _args = [
          "easeOutQuad"
          {
            type = "bezier";
            points = [[0.5 1] [0.89 1]];
          }
        ];
      }
    ];

    animation = [
      # ------------------------------- Windows -------------------------------
      {
        leaf = "windowsIn";
        enabled = true;
        speed = 4;
        bezier = "easeOutExpo";
        style = "popin 50%";
      }
      {
        leaf = "windowsOut";
        enabled = true;
        speed = 4;
        bezier = "easeOutExpo";
        style = "popin";
      }
      {
        leaf = "windowsMove";
        enabled = true;
        speed = 2;
        bezier = "easeInOutQuad";
      }

      # -------------------------------- Layers --------------------------------
      {
        leaf = "layers";
        enabled = false;
      }

      # --------------------------------- Fade ---------------------------------
      {
        leaf = "fadeIn";
        enabled = true;
        speed = 4;
        bezier = "easeOutExpo";
      }
      {
        leaf = "fadeOut";
        enabled = true;
        speed = 4;
        bezier = "easeOutExpo";
      }
      {
        leaf = "fadeSwitch";
        enabled = true;
        speed = 6;
        bezier = "easeOutExpo";
      }
      {
        leaf = "fadeShadow";
        enabled = false;
      }
      {
        leaf = "fadeDim";
        enabled = true;
        speed = 6;
        bezier = "easeOutExpo";
      }
      {
        leaf = "fadeLayers";
        enabled = true;
        speed = 4;
        bezier = "easeOutExpo";
      }
      {
        leaf = "fadePopups";
        enabled = false;
      }
      {
        leaf = "fadeDpms";
        enabled = true;
        speed = 10;
        bezier = "easeOutQuad";
      }

      # ------------------------------ Workspaces ------------------------------
      {
        leaf = "workspaces";
        enabled = true;
        speed = 3;
        bezier = "easeOutBack";
        style = "slidefade 10%";
      }
      {
        leaf = "specialWorkspace";
        enabled = true;
        speed = 3;
        bezier = "easeInOutQuad";
        style = "slidevert bottom 50%";
      }

      # --------------------------------- Misc ---------------------------------
      {
        leaf = "border";
        enabled = true;
        speed = 5;
        bezier = "easeOutQuad";
      }
      {
        leaf = "borderangle";
        enabled = false;
      }
      {
        leaf = "zoomFactor";
        enabled = true;
        speed = 3;
        bezier = "easeOutExpo";
      }
      {
        leaf = "monitorAdded";
        enabled = false;
      }
    ];
  };
}
