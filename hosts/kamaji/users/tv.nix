{
  config,
  lib,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  moonlight-gamescope = pkgs.writeShellScriptBin "moonlight-gamescope" ''
    systemctl --user start moonlight-gamescope-session.target
    ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
    gamescope --hdr-enabled --adaptive-sync -r 144 -- moonlight >"$HOME"/.gamescope-stdout.log 2>&1
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
      "audio"
      "video"
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

  services.displayManager.sessionPackages = [moonlight-gamescope-session];
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
