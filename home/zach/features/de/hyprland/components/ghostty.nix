{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;

    settings = {
    };
  };

  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
    };
  };
}
