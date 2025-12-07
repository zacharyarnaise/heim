{
  config,
  lib,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  moonlight-gamescope = pkgs.writeShellScriptBin "moonlight-gamescope" ''
    systemctl --user import-environment DISPLAY WAYLAND_DISPLAY
    systemctl --user start moonlight-gamescope-session.target
    ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
    gamescope --hdr-enabled --adaptive-sync -- moonlight &>/dev/null
    systemctl --user stop moonlight-gamescope-session.target
  '';
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

  systemd.user.targets.moonlight-gamescope-session = {
    description = "Moonlight session";
    bindsTo = ["graphical-session.target"];
    wants = ["graphical-session-pre.target"];
    after = ["graphical-session-pre.target"];
  };

  environment.systemPackages = [pkgs.moonlight-qt];
  programs.gamescope.enable = true;
  services.greetd = {
    enable = true;
    settings = let
      session = {
        command = "${lib.getExe moonlight-gamescope}";
        user = "tv";
      };
    in {
      default_session = session;
      initial_session = session;
    };
  };
}
