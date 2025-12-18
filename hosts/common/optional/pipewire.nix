{
  # Enable realtime to avoid audio glitches
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    wireplumber.extraConfig."wireplumber.profiles".main."monitor.libcamera" = "disabled";
  };
}
