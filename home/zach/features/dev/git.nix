{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (inputs) secrets;
in {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      delta
      difftastic
      ;
  };

  programs.git = {
    userName = "Zachary Arnaise";
    userEmail = "121795280+zacharyarnaise@users.noreply.github.com";

    extraConfig = {
      core.pager = "delta";
      delta = {
        features = [
          "line-numbers"
          "hyperlinks"
          "side-by-side"
          "commit-decoration"
          "decorations"
        ];
        navigate = true;
        light = false;
      };

      diff.tool = "difftastic";
      difftool = {
        prompt = "false";
        difftastic.cmd = ''difft "$LOCAL" "$REMOTE"'';
      };

      format.signOff = "false";
    };
    signing.signByDefault = true;

    includes = lib.mkIf config.hostSpec.isWork [
      {
        condition = "gitdir:${config.home.homeDirectory}/Code/Work/**";
        contents = secrets.work.git;
      }
    ];
  };
}
