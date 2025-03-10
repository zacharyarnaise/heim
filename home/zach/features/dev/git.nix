{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      delta
      difftastic
      ;
  };

  programs.git.extraConfig = {
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
  };
}
