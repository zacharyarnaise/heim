{
  services.samba = {
    enable = true;

    openFirewall = true;
    settings = {
      global = {
        "deadtime" = "15";
        "dns proxy" = "no";
        "keepalive" = "300";
        "invalid users" = ["root"];
        "load printers" = "no";
        "log level" = 0;
        "logging" = "systemd";
        "map to guest" = "never";
        "security" = "user";
        "server string" = "Samba Server";
        "workgroup" = "WORKGROUP";
      };

      storage = {
        "browseable" = "no";
        "create mask" = "0664";
        "directory mask" = "2770";
        "guest ok" = "no";
        "path" = "/storage";
        "public" = "no";
        "printable" = "no";
        "valid users" = "@media";
        "writable" = "yes";
      };
    };
  };
}
