{pkgs, ...}: {
  programs.noctalia-shell = {
    plugins = {
      version = 2;
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        polkit-agent = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        ssh-sessions = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
    };
    pluginSettings = {
      ssh-sessions = {
        pollInterval = 15;
        terminalCommand = "${pkgs.foot}/bin/footclient";
        showInactiveHosts = true;
      };
    };
  };
}
