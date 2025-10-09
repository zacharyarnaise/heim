{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (inputs) secrets;
in {
  programs.git = {
    userName = "Zachary Arnaise";
    userEmail = "121795280+zacharyarnaise@users.noreply.github.com";

    difftastic = {
      enable = true;
      enableAsDifftool = true;
      options = {
        background = "dark";
        color = "always";
        display = "side-by-side";
        context = 5;
      };
    };

    extraConfig.format.signOff = "false";
    signing.signByDefault = true;

    includes = lib.mkIf config.hostSpec.isWork [
      {
        condition = "gitdir:${config.home.homeDirectory}/Code/Work/**";
        contents = secrets.work.git;
      }
    ];
  };
}
