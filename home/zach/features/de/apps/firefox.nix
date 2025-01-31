{
  pkgs,
  inputs,
  config,
  ...
}: let
  firefox-addons = inputs.firefox-addons.packages.${pkgs.system};
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;

    policies = {
      NoDefaultBookmarks = true;
    };

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
          "cheat.sh"
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
          "cheat.sh" = {
            urls = [{template = "https://cheat.sh/{searchTerms}";}];
            iconUpdateURL = "https://cheat.sh/favicon.ico";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@chs"];
          };

          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Google".metaData.alias = "@g";
          "Wikipedia (en)".metaData.alias = "@w";
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
        "browser.feeds.showFirstRunUI" = false;
        "browser.eme.ui.firstContentShown" = true;
        "rowser.laterrun.enabled" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.newtabpage.introShown" = true;
        "browser.onboarding.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.firstrunSkipsHomepage" = true;
        "browser.translations.automaticallyPopup" = false;
        "browser.translations.panelShown" = true;
        "browser.uitour.enabled" = false;
        "devtools.everOpened" = true;
        "extensions.shield-recipe-client.enabled" = false;
        "extensions.update.enabled" = false;
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
        "browser.startup.homepage" = "about:home";
        "browser.startup.page" = 0;
        "startup.homepage_welcome_url" = "";
        "browser.aboutwelcome.enabled" = false;
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # DevTools
        "devtools.cache.disabled" = true;
        "devtools.debugger.remote-enabled" = false;
        "devtools.inspector.simple-highlighters-reduced-motion" = true;
        "devtools.inspector.simple-highlighters.message-dismisser" = true;
        "devtools.memory.enabled" = false;
        "devtools.popup.disable_autohide" = true;
        "devtools.popups.debug" = true;
        "devtools.toolbox.selectedTool" = "netmonitor";
        "devtools.theme" = "dark";

        # DNS-over-HTTPS
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://dns11.quad9.net/dns-query";

        # Telemetry stuff
        "app.normandy.enabled" = false;
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.coverage.enabled" = false;
        "toolkit.coverage.opt-out" = true;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;

        # Security / Privacy
        "accessibility.force_disabled" = 1;
        "browser.discovery.enabled" = false;
        "browser.discovery.containers.enabled" = false;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.pagethumbnails.capturing_disabled" = true;
        "browser.preferences.moreFromMozilla" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.privatebrowsing.preserveClipboard" = false;
        "browser.search.update" = false;
        "browser.send_pings" = false;
        "browser.topsites.component.enabled" = false;
        "browser.topsites.contile.enabled" = false;
        "browser.translations.enabled" = false;
        "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
        "browser.urlbar.suggest.recentsearches" = false;
        "clipboard.copyPrivateDataToClipboardCloudOrHistory" = false;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_send_http_background_request" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.discover.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "network.file.disable_unc_paths" = true;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "pdfjs.enableScripting" = false;
        "permissions.default.camera" = 2;
        "permissions.default.desktop-notification" = 2;
        "permissions.default.xr" = 2;
        "privacy.donottrackheader.enabled" = false;
        "privacy.purge_trackers.enabled" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.randomDataOnCanvasExtract" = true;
        "privacy.webrtc.legacyGlobalIndicator" = false;
        "security.cert_pinning.enforcement_level" = 2;
        "security.ssl.require_safe_negotiation" = true;
        "security.tls.enable_0rtt_data" = false;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "security.tls.version.enable-deprecated" = false;
        "security.xfocsp.errorReporting.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;

        # Misc.
        "browser.contentblocking.category" = "strict";
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.download.useDownloadDir" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.meta_refresh_when_inactive.disabled" = true;
        "browser.quitShortcut.disabled" = true;
        "browser.search.suggest.enabled" = false;
        "browser.tabs.firefox-view.ui-state.recentlyclosed.open" = false;
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
        "toolkit.cosmeticAnimations.enable" = false;
        "ui.osk.enabled" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Layout
        "browser.compactmode.show" = true;
        "browser.tabs.drawInTitlebar" = false;
        "browser.tabs.inTitlebar" = 1;
        "browser.uidensity" = 1;
        "ui.prefersReducedMotion" = 1;
        "ui.systemUsesDarkTheme" = 1;
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

  # Until I find a cleaner way to manage my bookmarks and stuff
  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = false;
      directories = [".mozilla/firefox"];
    };
  };
}
