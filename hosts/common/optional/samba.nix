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
        "security" = "user";
        "server string" = "Samba Server";
        "syslog" = 0;
        "syslog only" = "yes";
        "workgroup" = "WORKGROUP";
      };
      private = {
        "browseable" = "no";
        path = "/home/shannan/yellow.r";
        "force user" = "shannan";
        "force group" = "users";
        public = "yes";
        "guest ok" = "no";
        #"only guest" = "yes";
        "create mask" = "0644";
        "directory mask" = "2777";
        writable = "yes";
        printable = "no";
        "valid users" = "shannan";
      };
    };
  };
}
