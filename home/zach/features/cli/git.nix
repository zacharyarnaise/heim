{
  config,
  lib,
  ...
}: {
  programs.git = {
    enable = true;

    ignores = [
      ".direnv"
      ".env"
    ];

    userName = "Zachary Arnaise";
    userEmail = "121795280+zacharyarnaise@users.noreply.github.com";

    extraConfig = {
      log = {
        date = "iso";
        showSignature = true;
      };
      url = {
        "ssh://git@github.com".insteadOf = "https://github.com";
      };

      branch.autosetuprebase = "always";
      branch.sort = "committerdate";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      rerere.enabled = true;
      fetch.prune = true;
      pull.ff = "only";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  programs.zsh = lib.mkIf config.programs.zsh.enable {
    oh-my-zsh.plugins = ["git"];
  };
}
