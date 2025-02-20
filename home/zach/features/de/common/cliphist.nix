{
  services.cliphist = {
    enable = true;
    extraOptions = [
      "-max-items"
      "500"
      "-max-dedupe-search"
      "50"
    ];
  };

  systemd.user.services.cliphist = {
    Unit.StartLimitBurst = 30;
  };
  systemd.user.services.cliphist-images = {
    Unit.StartLimitBurst = 30;
  };
}
