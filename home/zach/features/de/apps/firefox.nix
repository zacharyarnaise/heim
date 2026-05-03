{
  pkgs,
  inputs,
  config,
  ...
}: let
  firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.system};
  firefox-ui-fix = pkgs.fetchFromGitHub {
    owner = "black7375";
    repo = "Firefox-UI-Fix";
    rev = "v8.7.5";
    fetchSubmodules = false;
    sha256 = "sha256-IfR5pI+tpP5RfoTqO6Vgnbc5nADqSA4gg+9csz/+pO0=";
  };
in {
  stylix.targets.firefox.profileNames = ["default"];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.default = {
      id = 0;
      extensions.packages = builtins.attrValues {
        inherit
          (firefox-addons)
          french-dictionary
          ublock-origin
          gopass-bridge
          multi-account-containers
          refined-github
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
          "Noogle"
          "golang"
          "Grep.app"
          "Sourcegraph Go"
          "Sourcegraph Nix"
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

          "golang" = {
            urls = [{template = "https://pkg.go.dev/search?q={searchTerms}";}];
            icon = "https://pkg.go.dev/static/shared/icon/favicon.ico";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@go"];
          };
          "Grep.app" = {
            urls = [{template = "https://grep.app/search?q={searchTerms}";}];
            icon = "https://grep.app/icon.png";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@gr"];
          };
          "Sourcegraph Go" = {
            urls = [{template = "https://sourcegraph.com/search?q=context:global+file:.go%24+{searchTerms}&patternType=literal";}];
            icon = "https://sourcegraph.com/favicon.ico";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@sgo"];
          };
          "Sourcegraph Nix" = {
            urls = [{template = "https://sourcegraph.com/search?q=context:global+file:.nix%24+{searchTerms}&patternType=literal";}];
            icon = "https://sourcegraph.com/favicon.ico";
            updateInterval = 7 * (24 * 60 * 60 * 1000);
            definedAliases = ["@snx"];
          };

          "amazondotcom-us".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "perplexity".metaData.hidden = true;
          "qwant".metaData.hidden = true;
          "google".metaData.alias = "@g";
          "wikipedia".metaData.alias = "@w";
        };
      };
      settings = {
        "accessibility.force_disabled" = 1;
        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.auto" = false;
        "breakpad.reportURL" = "";
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.bookmarks.addedImportButton" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.contentanalysis.enabled" = false;
        "browser.contentblocking.category" = "standard";
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.disableResetPrompt" = true;
        "browser.discovery.containers.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.download.always_ask_before_handling_new_types" = true;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.panel.shown" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.download.useDownloadDir" = false;
        "browser.eme.ui.firstContentShown" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.laterrun.enabled" = false;
        "browser.link.open_newwindow.restriction" = 0;
        "browser.meta_refresh_when_inactive.disabled" = true;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.page" = false;
        "browser.ml.chat.sidebar" = false;
        "browser.ml.linkPreview.optin" = true;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.enabled" = false;
        "browser.onboarding.enabled" = false;
        "browser.pagethumbnails.capturing_disabled" = true;
        "browser.preferences.moreFromMozilla" = false;
        "browser.preonboarding.enabled" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.privatebrowsing.preserveClipboard" = false;
        "browser.privatebrowsing.resetPBM.enabled" = true;
        "browser.quitShortcut.disabled" = true;
        "browser.region.network.scan" = false;
        "browser.region.network.url" = "";
        "browser.region.update.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.safebrowsing.enabled" = false;
        "browser.search.geoip.url" = "";
        "browser.search.geoSpecificDefaults.url" = "";
        "browser.search.suggest.enabled" = false;
        "browser.search.update" = false;
        "browser.send_pings" = false;
        "browser.sessionstore.resume_from_crash" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.slowStartup.notificationDisabled" = true;
        "browser.startup.blankWindow" = true;
        "browser.startup.firstrunSkipsHomepage" = true;
        "browser.startup.homepage" = "about:home";
        "browser.startup.page" = 0;
        "browser.startup.preXulSkeletonUI" = false;
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.tabs.drawInTitlebar" = false;
        "browser.tabs.insertAfterCurrent" = true;
        "browser.tabs.insertAfterCurrentExceptPinned" = true;
        "browser.tabs.inTitlebar" = 0;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.topsites.component.enabled" = false;
        "browser.topsites.contile.enabled" = false;
        "browser.touchmode.auto" = false;
        "browser.translations.automaticallyPopup" = false;
        "browser.translations.enable" = false;
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 23;
          newElementCount = 6;
          dirtyAreaCache = ["nav-bar" "PersonalToolbar" "unified-extensions-area" "toolbar-menubar" "TabsToolbar" "vertical-tabs" "widget-overflow-fixed-list"];
          seen = ["developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action" "tab-session-manager_sienori-browser-action" "_eec37db0-22ad-4bf1-9068-5ae08df8c7e9_-browser-action" "_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action" "screenshot-button"];
          placements = {
            widget-overflow-fixed-list = [];
            unified-extensions-area = ["_testpilot-containers-browser-action" "tab-session-manager_sienori-browser-action" "_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action"];
            nav-bar = ["sidebar-button" "back-button" "forward-button" "stop-reload-button" "urlbar-container" "downloads-button" "unified-extensions-button" "_eec37db0-22ad-4bf1-9068-5ae08df8c7e9_-browser-action" "ublock0_raymondhill_net-browser-action" "vertical-spacer"];
            toolbar-menubar = ["menubar-items"];
            TabsToolbar = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
            vertical-tabs = [];
            PersonalToolbar = ["personal-bookmarks"];
          };
        };
        "browser.uidensity" = 1;
        "browser.uitour.enabled" = false;
        "browser.uitour.url" = "";
        "browser.urlbar.quicksuggest.dataCollection.enabled" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.sponsoredTopSites" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.trimURLs" = false;
        "browser.urlbar.unitConversion.enabled" = true;
        "browser.urlbar.weather.featureGate" = false;
        "browser.urlbar.yelp.featureGate" = false;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "captivedetect.canonicalURL" = "";
        "content.notify.interval" = 100000;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "device.sensors.enabled" = false;
        "devtools.cache.disabled" = true;
        "devtools.debugger.remote-enabled" = false;
        "devtools.everOpened" = true;
        "devtools.inspector.simple-highlighters-reduced-motion" = true;
        "devtools.inspector.simple-highlighters.message-dismissed" = true;
        "devtools.memory.enabled" = false;
        "devtools.netmonitor.requestfilter" = "-method:OPTIONS";
        "devtools.popup.disable_autohide" = true;
        "devtools.popups.debug" = true;
        "devtools.theme" = "dark";
        "devtools.toolbox.host" = "window";
        "devtools.toolbox.selectedTool" = "netmonitor";
        "dom.battery.enabled" = false;
        "dom.disable_window_move_resize" = true;
        "dom.event.contextmenu.shift_suppresses_event" = true;
        "dom.gamepad.enabled" = false;
        "dom.security.https_only_mode_send_http_background_request" = false;
        "dom.security.https_only_mode" = true;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.postDownloadThirdPartyPrompt" = false;
        "extensions.update.autoUpdateDefault" = false;
        "extensions.update.enabled" = false;
        "extensions.webcompat-reporter.enabled" = false;
        "font.default.x-western" = "sans-serif";
        "general.smoothScroll" = false;
        "geo.enabled" = false;
        "geo.provider.ms-windows-location" = false;
        "geo.provider.use_corelocation" = false;
        "geo.provider.use_geoclue" = false;
        "gfx.webrender.all" = true;
        "intl.accept_languages" = "en-US, en";
        "layers.acceleration.disabled" = false;
        "layers.acceleration.force-enabled" = true;
        "media.autoplay.blocking_policy" = 2;
        "media.autoplay.default" = 5;
        "messaging-system.askForFeedback" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        "network.file.disable_unc_paths" = true;
        "network.gio.supported-protocols" = "";
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.sendRefererHeader" = 2;
        "network.IDN_show_punycode" = true;
        "network.notify.checkForProxies" = false;
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://dns11.quad9.net/dns-query";
        "nglayout.initialpaint.delay_in_oopif" = 0;
        "nglayout.initialpaint.delay" = 0;
        "pdfjs.enableScripting" = false;
        "permissions.default.camera" = 2;
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "permissions.default.local-network" = 2;
        "permissions.default.loopback-network" = 2;
        "permissions.default.xr" = 2;
        "plugins.enumerable_names" = "";
        "privacy.antitracking.enableWebcompat" = false;
        "privacy.donottrackheader.enabled" = false;
        "privacy.exposeContentTitleInWindow.pbm" = false;
        "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
        "privacy.fingerprintingProtection" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;
        "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = false;
        "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
        "privacy.purge_trackers.enabled" = true;
        "privacy.query_stripping.strip_list" = "__hsfp __hssc __hstc __s _hsenc _openstat dclid fbclid gbraid gclid hsCtaTracking igshid mc_eid ml_subscriber ml_subscriber_hash msclkid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id rb_clickid s_cid twclid vero_conv vero_id wbraid wickedid yclid";
        "privacy.resistFingerprinting" = false;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.newTabContainerOnLeftClick.enabled" = false;
        "privacy.userContext.ui.enabled" = true;
        "security.cert_pinning.enforcement_level" = 2;
        "security.certerrors.mitm.priming.enabled" = false;
        "security.certerrors.recordEventTelemetry" = false;
        "security.dialog_enable_delay" = 1000;
        "security.OCSP.enabled" = 1;
        "security.OCSP.require" = true;
        "security.pki.crlite_mode" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.ssl.require_safe_negotiation" = true;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "security.ssl3.dhe_dss_aes_128_sha" = false;
        "security.ssl3.dhe_rsa_aes_128_sha" = false;
        "security.ssl3.dhe_rsa_aes_256_sha" = false;
        "security.ssl3.rsa_seed_sha" = true;
        "security.tls.enable_0rtt_data" = false;
        "security.tls.insecure_fallback_hosts.use_static_list" = false;
        "security.tls.unrestricted_rc4_fallback" = false;
        "security.tls.version.enable-deprecated" = false;
        "security.tls.version.min" = 3;
        "services.sync.declinedEngines" = "addons,addresses,creditcards,passwords,prefs";
        "services.sync.engine.addons" = false;
        "services.sync.engine.addresses" = false;
        "services.sync.engine.bookmarks" = true;
        "services.sync.engine.creditcards" = false;
        "services.sync.engine.history" = true;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.tabs" = true;
        "signon.firefoxRelay.feature" = "disabled";
        "signon.management.page.breach-alerts.enabled" = false;
        "signon.rememberSignons" = false;
        "startup.homepage_welcome_url" = "";
        "svg.context-properties.content.enabled" = true;
        "toolkit.cosmeticAnimations.enabled" = false;
        "toolkit.coverage.enabled" = false;
        "toolkit.coverage.endpoint.base" = "";
        "toolkit.coverage.opt-out" = true;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "ui.osk.enabled" = false;
        "ui.prefersReducedMotion" = 1;
        "ui.systemUsesDarkTheme" = 1;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
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
