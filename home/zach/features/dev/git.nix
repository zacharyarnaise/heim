{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (inputs) secrets;
in {
  programs = {
    difftastic = {
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

    git = {
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

    lazygit = {
      enable = true;
      settings = {
        disableStartupPopups = true;
        git = {
          diffContextSize = 4;
          mainBranches = ["main" "master" "develop"];
        };
        gui = {
          commandLogSize = 5;
          language = "en";
          nerdFontsVersion = "3";
          shortTimeFormat = "15:04:05";
          showBranchCommitHash = true;
          showNumstatInFilesView = true;
          timeFormat = "Mon 02/01/2006 15:04";
          showRootItemInFileTree = false;
          fileTreeSortOrder = "foldersFirst";
          showDivergenceFromBaseBranch = "arrowAndNumber";
        };
        update.method = "never";
      };
    };
  };
}
