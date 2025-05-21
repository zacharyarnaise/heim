{pkgs, ...}: {
  stylix.targets.vscode.profileNames = ["default"];

  programs.vscode = {
    enable = true;

    mutableExtensionsDir = false;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = let
        vsext = pkgs.vscode-extensions;
      in [
        vsext.jnoortheen.nix-ide

        vsext.golang.go

        vsext.ms-python.python
        vsext.ms-python.vscode-pylance
        vsext.ms-python.isort

        vsext.github.copilot
        vsext.vscode-icons-team.vscode-icons
      ];
      userSettings = {
        "editor.codeActionsOnSave" = {
          "source.organizeImports" = "explicit";
          "source.sortImports" = "explicit";
        };
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "modificationsIfAvailable";
        "notebook.formatOnSave.enabled" = true;
        "files.autoSave" = "afterDelay";
        "files.insertFinalNewline" = true;
        "editor.renderWhitespace" = "all";
        "editor.rulers" = [80];
        "extensions.ignoreRecommendations" = true;
        "git.confirmSync" = false;
        "window.titleBarStyle" = "native";
        "workbench.iconTheme" = "vscode-icons";
        "workbench.startupEditor" = "none";
        "vsicons.dontShowNewVersionMessage" = true;
        "security.workspace.trust.enabled" = false;

        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nil.formatting.command" = ["alejandra"];
        };

        "go.formatTool" = "goimports";

        "python.analysis.indexing" = true;
        "python.analysis.autoImportCompletions" = true;
      };
    };
  };
}
