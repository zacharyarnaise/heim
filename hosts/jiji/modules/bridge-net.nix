{
  systemd.network = {
    netdevs."20-br0" = {
      netdevConfig = {
        Name = "br0";
        Description = "br0 bridge";
        Kind = "bridge";
      };
    };
    networks."50-br0" = {
      name = "br0";
      address = ["10.100.1.1/24"];
      routes = [
        {
          Destination = "10.0.1.0/24";
          Scope = "host";
          Type = "local";
        }
      ];
    };
  };
}
