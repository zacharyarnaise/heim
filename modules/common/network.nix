{lib, ...}: {
  options.heim.net = lib.mkOption {
    type = lib.types.attrs;
    readOnly = true;
    description = "Internal network IPs";
    default = {
      wg = {
        subnet = "10.0.0.0/24";
        jiji = "10.0.0.1";
        calcifer = "10.0.0.2";
        ponyo = "10.0.0.4";
      };
      services = {
        subnet = "10.0.1.0/24";
        atuin = {
          ip = "10.0.1.1";
          port = 8888;
        };
        navidrome = {
          ip = "10.0.1.2";
          port = 4533;
        };
        slskd = {
          ip = "10.0.1.3";
          port = 5030;
        };
        nextcloud = {
          ip = "10.0.1.4";
        };
      };
    };
  };
}
