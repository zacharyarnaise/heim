{
  imports = [
    ../common/optional/samba.nix
  ];

  services.samba.settings = {
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
}
