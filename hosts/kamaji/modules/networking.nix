{
  systemd.network = {
    netdevs."10-dummy0" = {
      netdevConfig = {
        Kind = "dummy";
        Name = "dummy0";
      };
    };
    networks."10-dummy0" = {
      name = "dummy0";
      addresses = [
        {
          Address = "10.0.1.1/32";
          Scope = "host";
        }
      ];
    };
  };
}
