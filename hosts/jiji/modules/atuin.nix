{
  networking.firewall.interfaces.wg0.allowedTCPPorts = [8888];

  services.atuin = {
    enable = true;
    host = "10.0.1.1";
    port = 8888;
    openFirewall = false;
  };
}
