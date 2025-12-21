{
  config,
  lib,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  moonlight-gamescope = pkgs.writeShellScriptBin "moonlight-gamescope" ''
    systemctl --user start moonlight-gamescope-session.target
    ${pkgs.pulseaudio}/bin/pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:hdmi-surround
    ${pkgs.pulseaudio}/bin/pactl set-sink-port alsa_output.pci-0000_00_1f.3.hdmi-surround hdmi-output-0
    ${pkgs.pulseaudio}/bin/pactl set-default-sink alsa_output.pci-0000_00_1f.3.hdmi-surround
    ${pkgs.pulseaudio}/bin/pactl set-sink-volume alsa_output.pci-0000_00_1f.3.hdmi-surround 100%
    gamescope --hdr-enabled --adaptive-sync -r 144 -- moonlight &>/dev/null
    systemctl --user stop moonlight-gamescope-session.target
  '';
  moonlight-gamescope-session =
    (pkgs.writeTextDir "share/wayland-sessions/moonlight.desktop" ''
      [Desktop Entry]
      Name=Moonlight
      Comment=GameStream client
      Exec=${lib.getExe moonlight-gamescope}
      Type=Application
    '').overrideAttrs
    (_: {
      passthru.providedSessions = ["moonlight"];
    });
in {
  users.groups.tv = {};
  users.users.tv = {
    isNormalUser = true;
    group = "tv";
    extraGroups = ifTheyExist [
      "media"
    ];
    password = lib.mkForce null;
    hashedPassword = "";
  };

  environment.persistence = {
    "/persist".directories = [
      {
        directory = "/home/tv";
        user = "tv";
        group = "tv";
      }
    ];
  };

  services.displayManager = {
    sessionPackages = [moonlight-gamescope-session];
    autoLogin = {
      enable = true;
      user = "tv";
    };
  };
  systemd.user.targets.moonlight-gamescope-session = {
    description = "Moonlight session";
    bindsTo = ["graphical-session.target"];
    wants = ["graphical-session-pre.target"];
    after = ["graphical-session-pre.target"];
  };

  environment.systemPackages = [pkgs.moonlight-qt];
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
