{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (inputs) secrets;
in {
  programs.difftastic = {
    enable = true;
    git.enable = true;
    git.diffToolMode = true;
    options = {
      background = "dark";
      color = "always";
      display = "side-by-side";
      context = 5;
    };
  };

  programs.git = {
    settings = {
      format.signOff = "false";
      user.email = "121795280+zacharyarnaise@users.noreply.github.com";
      user.name = "Zachary Arnaise";
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
