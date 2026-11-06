{
  programs.git = {
    enable = true;

    ignores = [
      ".direnv"
      ".env"
      ".envrc"
    ];

    settings = {
      log.date = "iso";
      url = {
        "ssh://git@github.com/".pushInsteadOf = "https://github.com/";
      };

      core.whitespace = "-trailing-space";
      branch.sort = "committerdate";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      rerere.enabled = true;
      fetch.prune = true;
      pull.ff = "only";
      push.autoSetupRemote = true;
    };
  };
}
