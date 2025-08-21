{
  pkgs,
  inputs,
  ...
}: let
  firefox-addons = inputs.firefox-addons.packages.${pkgs.system};
  firefox-ui-fix = pkgs.fetchFromGitHub {
    owner = "black7375";
    repo = "Firefox-UI-Fix";
    rev = "v8.7.3";
    fetchSubmodules = false;
    sha256 = "sha256-2AIUzfWp7RhhW5Ku1qYTxr0y+1qpfCIHPVv3wdI2VyU=";
  };
in {
  stylix.targets.firefox.profileNames = ["default"];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;

    profiles.default = {
      id = 0;
      extensions.packages = builtins.attrValues {
        inherit
          (firefox-addons)
          french-dictionary
          ublock-origin
          gopass-bridge
          multi-account-containers
          ;
      };
      search = {
        force = true;
        default = "ddg";
        order = [
          "ddg"
          "google"
          "wikipedia"
          "NixOS packages"
          "NixOS options"
          "Home-Manager options"
          "cheat.sh"
          "Grep.app"
          "reddit"
        ];

        engines = {
          "NixOS packages" = {
            urls = [{template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nxp"];
          };
          "NixOS options" = {
            urls = [{template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nxo"];
          };
          "Home-Manager options" = {
            urls = [{template = "https://home-manager-options.extranix.com?release=master&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nxh"];
          };
          "Noogle" = {
            urls = [{template = "https://noogle.dev/q?term={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@ngl"];
          };
          "Grep.app" = {
            urls = [{template = "https://grep.app/search?q={searchTerms}";}];
            icon = "https://grep.app/static/icon.png";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@gr"];
          };
          "reddit" = {
            urls = [{template = "https://old.reddit.com/search?q={searchTerms}";}];
            icon = "https://www.redditstatic.com/shreddit/assets/favicon/128x128.png";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@rd"];
          };
          "cheat.sh" = {
            urls = [{template = "https://cheat.sh/{searchTerms}";}];
            icon = "https://cheat.sh/favicon.ico";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@chs"];
          };

          "amazondotcom-us".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "google".metaData.alias = "@g";
          "wikipedia".metaData.alias = "@w";
        };
      };
      settings = {
        # Disable first-run/whats-new stuff
        "app.update.auto" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.eme.ui.firstContentShown" = true;
        "rowser.laterrun.enabled" = false;
        "browser.preonboarding.enabled" = false;
        "browser.sessionstore.resume_from_crash" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.firstrunSkipsHomepage" = true;
        "browser.translations.automaticallyPopup" = false;
        "browser.uitour.enabled" = false;
        "devtools.everOpened" = true;
        "extensions.update.autoUpdateDefault" = false;
        "extensions.update.enabled" = false;
        "messaging-system.askForFeedback" = false;
        "messaging-system.rsexperimentloader.enabled" = false;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;
        "signon.firefoxRelay.feature" = "disabled";
        "trailhead.firstrun.didSeeAboutWelcome" = true;

        # URL bar
        "browser.urlbar.addons.featureGate" = false;
        "browser.urlbar.fakespot.featureGate" = false;
        "browser.urlbar.pocket.featureGate" = false;
        "browser.urlbar.yelp.featureGate" = false;
        "browser.urlbar.weather.featureGate" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.sponsoredTopSites" = false;
        "browser.urlbar.suggest.addons" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.fakespot" = false;
        "browser.urlbar.suggest.mdn" = false;
        "browser.urlbar.suggest.pocket" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.trending" = false;
        "browser.urlbar.suggest.weather" = false;
        "browser.urlbar.suggest.yelp" = false;
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.quicksuggest.dataCollection.enabled" = false;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;

        # Homepage
        "browser.startup.blankWindow" = true;
        "browser.startup.page" = 0;
        "startup.homepage_welcome_url" = "";
        "browser.aboutwelcome.enabled" = false;
        "browser.newtabpage.enabled" = false;

        # DevTools
        "devtools.cache.disabled" = true;
        "devtools.debugger.remote-enabled" = false;
        "devtools.inspector.simple-highlighters-reduced-motion" = true;
        "devtools.inspector.simple-highlighters.message-dismissed" = true;
        "devtools.memory.enabled" = false;
        "devtools.popup.disable_autohide" = true;
        "devtools.popups.debug" = true;
        "devtools.toolbox.selectedTool" = "netmonitor";
        "devtools.theme" = "dark";
        "devtools.netmonitor.requestfilter" = "-method:OPTIONS";

        # DNS-over-HTTPS
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://dns11.quad9.net/dns-query";

        # Telemetry stuff
        "app.normandy.enabled" = false;
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.safebrowsing.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.coverage.enabled" = false;
        "toolkit.coverage.opt-out" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;

        # Security / Privacy
        "accessibility.typeaheadfind.flashBar" = 0;
        "accessibility.force_disabled" = 1;
        "browser.contentblocking.category" = "standard";
        "browser.discovery.enabled" = false;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.pagethumbnails.capturing_disabled" = true;
        "browser.preferences.moreFromMozilla" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.privatebrowsing.preserveClipboard" = false;
        "browser.search.suggest.enabled" = false;
        "browser.search.update" = false;
        "browser.send_pings" = false;
        "browser.topsites.component.enabled" = false;
        "browser.topsites.contile.enabled" = false;
        "browser.translations.enabled" = false;
        "dom.security.https_only_mode" = true;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "network.file.disable_unc_paths" = true;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "pdfjs.enableScripting" = false;
        "permissions.default.camera" = 2;
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "permissions.default.xr" = 2;
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.exposeContentTitleInWindow.pbm" = false;
        "privacy.purge_trackers.enabled" = true;
        "security.cert_pinning.enforcement_level" = 2;
        "security.ssl.require_safe_negotiation" = true;
        "security.tls.enable_0rtt_data" = false;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "security.tls.version.enable-deprecated" = false;
        "security.xfocsp.errorReporting.enabled" = false;
        "services.sync.declinedEngines" = "creditcards,prefs,passwords,addons";
        "signon.management.page.breach-alerts.enabled" = false;
        "signon.rememberSignons" = false;

        # Misc.
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.download.useDownloadDir" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.meta_refresh_when_inactive.disabled" = true;
        "browser.quitShortcut.disabled" = true;
        "browser.tabs.insertAfterCurrent" = true;
        "browser.tabs.insertAfterCurrentExceptPinned" = true;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.touchmode.auto" = false;
        "media.autoplay.blocking_policy" = 2;
        "media.autoplay.default" = 5;
        "network.notify.checkForProxies" = false;
        "general.smoothScroll" = false;
        "gfx.webrender.all" = true;
        "layers.acceleration.disabled" = false;
        "layers.acceleration.force-enabled" = true;
        "toolkit.cosmeticAnimations.enabled" = false;
        "ui.osk.enabled" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Layout / UI
        "browser.tabs.drawInTitlebar" = false;
        "browser.tabs.inTitlebar" = 0;
        "browser.uidensity" = 1;
        "svg.context-properties.content.enabled" = true;
        "ui.prefersReducedMotion" = 1;
        "ui.systemUsesDarkTheme" = 1;
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 21;
          newElementCount = 6;
          dirtyAreaCache = ["nav-bar" "PersonalToolbar" "unified-extensions-area" "toolbar-menubar" "TabsToolbar" "vertical-tabs" "widget-overflow-fixed-list"];
          seen = ["save-to-pocket-button" "developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action" "tab-session-manager_sienori-browser-action" "_eec37db0-22ad-4bf1-9068-5ae08df8c7e9_-browser-action"];
          placements = {
            widget-overflow-fixed-list = [];
            unified-extensions-area = ["_testpilot-containers-browser-action" "tab-session-manager_sienori-browser-action"];
            nav-bar = ["back-button" "forward-button" "stop-reload-button" "urlbar-container" "downloads-button" "unified-extensions-button" "_eec37db0-22ad-4bf1-9068-5ae08df8c7e9_-browser-action" "ublock0_raymondhill_net-browser-action"];
            toolbar-menubar = ["menubar-items"];
            TabsToolbar = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
            vertical-tabs = [];
            PersonalToolbar = ["personal-bookmarks"];
          };
        };
      };

      # Lepton style from firefox-ui-fix
      extraConfig = ''
        ${builtins.readFile "${firefox-ui-fix}/user.js"}
      '';
      userChrome = ''
        @import "${firefox-ui-fix}/userChrome.css";
      '';
      userContent = ''
        @import "${firefox-ui-fix}/userContent.css";
      '';
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
