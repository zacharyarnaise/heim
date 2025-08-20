{
  pkgs,
  config,
  lib,
  ...
}: {
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

        vsext.charliermarsh.ruff
        vsext.ms-python.python
        vsext.ms-python.vscode-pylance
        vsext.ms-kubernetes-tools.vscode-kubernetes-tools

        vsext.redhat.ansible
        vsext.redhat.vscode-yaml

        vsext.github.copilot
        vsext.teabyii.ayu
        vsext.vscode-icons-team.vscode-icons
      ];
      userSettings = {
        "extensions.autoUpdate" = false;
        "extensions.ignoreRecommendations" = true;
        "security.workspace.trust.enabled" = false;
        "redhat.telemetry.enabled" = false;
        "telemetry.telemetryLevel" = "off";
        "telemetry.feedback.enabled" = false;
        "vsicons.dontShowNewVersionMessage" = true;
        "update.showReleaseNotes" = false;
        "window.customTitleBarVisibility" = "never";
        "window.dialogStyle" = "native";
        "window.menuBarVisibility" = "toggle";
        "window.openFoldersInNewWindow" = "off";
        "window.titleBarStyle" = "native";
        "window.restoreWindows" = "none";

        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 5000;
        "files.insertFinalNewline" = true;
        "files.trimTrailingWhitespace" = true;

        "editor.bracketPairColorization.enabled" = true;
        "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
        "editor.cursorBlinking" = "blink";
        "editor.cursorStyle" = "line-thin";
        "editor.codeActionsOnSave"."source.fixAll" = "always";
        "editor.fontLigatures" = true;
        "editor.formatOnPaste" = false;
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "file";
        "editor.guides.bracketPairs" = "active";
        "editor.guides.bracketPairsHorizontal" = "active";
        "editor.guides.indentation" = true;
        "editor.inlayHints.enabled" = "on";
        "editor.inlayHints.fontSize" = 12;
        "editor.inlayHints.padding" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.lineNumbers" = "on";
        "editor.linkedEditing" = true;
        "editor.minimap.enabled" = false;
        "editor.mouseWheelZoom" = true;
        "editor.overviewRulerBorder" = false;
        "editor.renderWhitespace" = "boundary";
        "editor.rulers" = [80];
        "editor.semanticHighlighting.enabled" = true;
        "editor.snippetSuggestions" = "top";
        "editor.stickyScroll.enabled" = true;
        "editor.suggest.preview" = true;
        "editor.suggest.shareSuggestSelections" = true;
        "editor.suggestSelection" = "recentlyUsedByPrefix";
        "editor.trimAutoWhitespace" = true;
        "editor.wordWrap" = "off";
        "editor.wrappingIndent" = "indent";

        "explorer.confirmDelete" = false;

        "search.actionsPosition" = "auto";
        "search.collapseResults" = "auto";
        "search.defaultViewMode" = "tree";
        "search.smartCase" = true;

        "workbench.activityBar.location" = "top";
        "workbench.colorTheme" = lib.mkForce "Ayu Dark Bordered";
        "workbench.editor.empty.hint" = "hidden";
        "workbench.editor.enablePreview" = false;
        "workbench.editor.highlightModifiedTabs" = true;
        "workbench.editor.tabActionCloseVisibility" = false;
        "workbench.iconTheme" = "vscode-icons";
        "workbench.sideBar.location" = "right";
        "workbench.startupEditor" = "none";
        "workbench.tree.indent" = 12;

        "github.copilot.enable" = {
          "*" = true;
          "markdown" = true;
          "plaintext" = false;
          "scminput" = false;
        };

        "ansible.ansible.path" = "${pkgs.ansible}/bin/ansible";
        "ansible.validation.lint.path" = "${pkgs.ansible-lint}/bin/ansible-lint";
        "ansible.python.interpreterPath" = "${pkgs.python312}/bin/python3";

        "go.alternateTools" = {
          "delve" = "${pkgs.delve}/bin/dlv";
          "gofumpt" = "${pkgs.gofumpt}/bin/gofumpt";
          "goimports" = "${pkgs.gotools}/bin/goimports";
          "golangci-lint-v2" = "${pkgs.golangci-lint}/bin/golangci-lint";
          "gomodifytags" = "${pkgs.gomodifytags}/bin/gomodifytags";
          "gopls" = "${pkgs.gopls}/bin/gopls";
          "staticcheck" = "${pkgs.go-tools}/bin/staticcheck";
        };
        "go.diagnostic.vulncheck" = "Imports";
        "go.inlayHints.constantValues" = true;
        "go.inlayHints.rangeVariableTypes" = true;
        "go.lintTool" = "golangci-lint-v2";
        "go.showWelcome" = false;
        "go.survey.prompt" = false;
        "go.terminal.activateEnvironment" = false;
        "go.toolsEnvVars" = {
          "GOBIN" = "${config.home.homeDirectory}/${config.programs.go.goBin}";
          "GOPATH" = "${config.home.homeDirectory}/${config.programs.go.goPath}";
          "GOPRIVATE" = config.programs.go.goPrivate;
          "GOTELEMETRY" = config.programs.go.telemetry.mode;
        };
        "go.toolsManagement.autoUpdate" = false;
        "go.toolsManagement.checkForUpdates" = "off";
        "go.useLanguageServer" = true;
        "gopls"."ui.semanticTokens" = true;

        "nix.enableLanguageServer" = true;
        "nix.hiddenLanguageServerErrors" = [
          "textDocument/documentSymbol"
          "textDocument/formatting"
        ];
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];

        "[python]" = {
          "editor.codeActionsOnSave"."source.organizeImports.ruff" = "explicit";
          "editor.defaultFormatter" = "charliermarsh.ruff";
          "editor.formatOnSaveMode" = "modifications";
        };
        "python.analysis.autoImportCompletions" = true;
        "python.analysis.cacheLSPData" = true;
        "python.analysis.displayEnglishDiagnostics" = true;
        "python.analysis.enablePytestSupport" = false;
        "python.analysis.indexing" = true;
        "python.analysis.inlayHints.callArgumentNames" = "partial";
        "python.analysis.inlayHints.functionReturnTypes" = true;
        "python.analysis.inlayHints.variableTypes" = true;
        "python.analysis.languageServerMode" = "full";
        "python.analysis.typeCheckingMode" = "basic";
        "python.languageServer" = "Pylance";
      };
    };
  };
}
