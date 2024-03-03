{lib, ...}: {
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = lib.mkDefault true;
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = lib.mkDefault "no";
    };
  };
}
