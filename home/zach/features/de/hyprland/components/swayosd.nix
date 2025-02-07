{config, ...}: {
  services.swayosd = {
    enable = true;

    display = config.primaryMonitor.name;
    topMargin = 0.1;
  };

  xdg.configFile."swayosd/style.css".text = ''
    window {
      padding: 0.75em 1.25px;
      border-radius: 10em;
      border: 3em;
      background: alpha(#000, 0.4);
    }

    #container {
      margin: 1em;
    }

    image, label {
      color: #FFFFFF;
    }

    progressbar:disabled, image:disabled {
      opacity: 0.8;
    }

    progressbar {
      min-height: 0.4em;
      border-radius: 10em;
      background: transparent;
      border: none;
    }

    trough {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background: alpha(#CCCCCC, 0.1);
    }

    progress {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background: #FFFFFF;
    }
  '';
}
