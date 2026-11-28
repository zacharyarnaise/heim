{config, ...}: {
  networking.firewall.interfaces.wg0.allowedTCPPorts = [
    config.heim.net.services.atuin.port
  ];

  services.atuin = {
    enable = true;
    host = config.heim.net.services.atuin.ip;
    port = config.heim.net.services.atuin.port;
    openFirewall = false;
  };
}
