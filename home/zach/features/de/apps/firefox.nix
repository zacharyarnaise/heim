{
  pkgs,
  inputs,
  ...
}: let
  firefox-addons = inputs.firefox-addons.packages.${pkgs.system};
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta-bin;

    profiles.default = {
      id = 0;
      extensions = builtins.attrValues {
        inherit
          (firefox-addons)
          french-dictionary
          ublock-origin
          ;
      };
      search = {
        force = true;
        default = "DuckDuckGo";
        order = [
          "DuckDuckGo"
          "Google"
          "Wikipedia (en)"
          "NixOS packages"
          "NixOS options"
          "Home-Manager options"
          "Grep.app"
          "Reddit"
        ];

        engines = {
          "NixOS packages" = {
            urls = [{template = "https://search.nixos.org/packages?channel=24.11&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nxp"];
          };
          "NixOS options" = {
            urls = [{template = "https://search.nixos.org/options?channel=24.11&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nxo"];
          };
          "Home-Manager options" = {
            urls = [{template = "https://home-manager-options.extranix.com?release=release-24.11&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nxh"];
          };
          "Grep.app" = {
            urls = [{template = "https://grep.app/search?q={searchTerms}";}];
            iconUpdateURL = "https://grep.app/static/images/icon-32x32.ae2f571e.png";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@gr"];
          };
          "Reddit" = {
            urls = [{template = "https://old.reddit.com/search?q={searchTerms}";}];
            iconUpdateURL = "https://www.redditstatic.com/shreddit/assets/favicon/128x128.png";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@rd"];
          };

          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Qwant".metaData.hidden = true;
          "Google".metaData.alias = "@g";
          "Wikipedia (en)".metaData.alias = "@w";
        };
      };
      settings = {
        # Disable first-run/whats-new stuff
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.eme.ui.firstContentShown" = true;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.firstrunSkipsHomepage" = true;
        "browser.translations.automaticallyPopup" = false;
        "browser.translations.panelShown" = true;
        "browser.uitour.enabled" = false;
        "messaging-system.rsexperimentloader.enabled" = false;
        "signon.firefoxRelay.feature" = "disabled";
        "trailhead.firstrun.didSeeAboutWelcome" = true;

        # Homepage + disable new tab page
        "browser.startup.blankWindow" = true;
        "browser.startup.homepage" = "about:home";
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "startup.homepage_welcome_url" = "";
        "browser.aboutwelcome.enabled" = false;

        # DevTools
        "devtools.cache.disabled" = true;
        "devtools.everOpened" = true;
        "devtools.memory.enabled" = false;
        "devtools.popup.disable_autohide" = true;
        "devtools.popups.debug" = true;
        "devtools.theme" = "dark";

        # Telemetry stuff
        "app.normandy.enabled" = false;
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.discovery.containers.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.send_pings" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.coverage.enabled" = false;
        "toolkit.coverage.opt-out" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.archive.enabled" = false;

        # Security / Privacy
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.pagethumbnails.capturing_disabled" = true;
        "browser.preferences.moreFromMozilla" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.privatebrowsing.preserveClipboard" = false;
        "browser.search.update" = false;
        "browser.translations.enabled" = false;
        "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
        "browser.urlbar.suggest.addons" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.trending" = false;
        "browser.urlbar.suggest.weather" = false;
        "clipboard.copyPrivateDataToClipboardCloudOrHistory" = false;
        "dom.security.https_only_mode" = true;
        "extensions.pocket.enabled" = false;
        "geo.enabled" = false;
        "permissions.default.camera" = 2;
        "permissions.default.desktop-notification" = 2;
        "permissions.default.xr" = 2;
        "privacy.donottrackheader.enabled" = false;
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.randomDataOnCanvasExtract" = true;
        "security.ssl.require_safe_negotiation" = true;
        "security.tls.version.enable-deprecated" = false;
        "security.xfocsp.errorReporting.enabled" = false;

        # Misc.
        "browser.uidensity" = 1;
        "browser.contentblocking.category" = "standard";
        "browser.download.useDownloadDir" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.tabs.insertAfterCurrent" = true;
        "browser.tabs.insertAfterCurrentExceptPinned" = true;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.touchmode.auto" = false;

        # Layout
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 21;
          newElementCount = 3;
          dirtyAreaCache = ["nav-bar" "PersonalToolbar" "unified-extensions-area" "toolbar-menubar" "TabsToolbar" "vertical-tabs" "widget-overflow-fixed-list"];
          seen = ["save-to-pocket-button" "developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action"];
          placements = {
            widget-overflow-fixed-list = [];
            unified-extensions-area = [];
            nav-bar = ["back-button" "forward-button" "stop-reload-button" "urlbar-container" "downloads-button" "unified-extensions-button" "ublock0_raymondhill_net-browser-action"];
            toolbar-menubar = ["menubar-items"];
            TabsToolbar = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
            vertical-tabs = [];
            PersonalToolbar = ["personal-bookmarks"];
          };
        };
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
