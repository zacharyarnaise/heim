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
        "ssh://git@github.com".insteadOf = "https://github.com";
      };

      core.whitespace = "-trailing-space";
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
}
