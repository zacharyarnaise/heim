{
  lib,
  pkgs,
  ...
}: {
  # PipeWire requires pulseaudio to be disabled
  #hardware.pulseaudio.enable = lib.mkForce false;
  # Enable realtime to avoid audio glitches
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      package = pkgs.wireplumber;
    };
  };
}
