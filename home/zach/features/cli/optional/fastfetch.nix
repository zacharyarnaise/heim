{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = ./calcifer.sixel;
        type = "raw";
        width = 25;
        padding = {
          top = 3;
          left = 1;
          right = 2;
        };
      };
      display = {
        key = {
          type = "both";
          paddingLeft = 2;
        };
        separator = "   ";
        size.binaryPrefix = "iec";
      };
      modules = [
        {
          type = "title";
        }
        {
          type = "custom";
          format = "┌───────────────────────────────────────────────────────────────────┐";
        }
        {
          type = "os";
          keyColor = "1;38;5;160";
        }
        {
          type = "kernel";
          keyColor = "1;38;5;124";
        }
        {
          type = "packages";
          keyColor = "1;38;5;214";
        }
        {
          type = "wm";
          format = "{pretty-name} {version}";
          keyColor = "1;38;5;220";
        }
        {
          type = "terminal";
          keyIcon = "";
          format = "{pretty-name} {version}";
          keyColor = "1;38;5;221";
        }
        {
          type = "shell";
          keyIcon = "󰘳";
          format = "{pretty-name} {version}";
          keyColor = "1;38;5;222";
        }
        "break"
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
        "break"
        {
          type = "cpu";
          format = "{name} @ {freq-max}";
          keyColor = "1;38;5;38";
        }
        {
          type = "gpu";
          format = "{name} - {driver}";
          keyColor = "1;38;5;38";
        }
        {
          type = "memory";
          keyColor = "1;38;5;39";
        }
        {
          type = "disk";
          keyColor = "1;38;5;39";
        }
        {
          type = "display";
          keyColor = "1;38;5;134";
          format = "{inch}\" - {width}x{height}@{refresh-rate}Hz";
        }
        {
          type = "sound";
          keyColor = "1;38;5;134";
          format = "{name}";
        }
        {
          type = "custom";
          format = "└───────────────────────────────────────────────────────────────────┘";
        }
      ];
    };
  };
}
