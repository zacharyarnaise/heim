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
    StartLimitBurst = 30;
  };
  systemd.user.services.cliphist-images = {
    StartLimitBurst = 30;
  };
}
