{pkgs, ...}: {
  programs.go = {
    enable = true;
    package = pkgs.go_1_24;

    goPath = ".go";
    goBin = ".go/bin";
    goPrivate = [
      "github.com/charmbracelet"
      "github.com/meowgorithm"
    ];
  };

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      goimports
      gopls
      gotools
      ;
  };
}
