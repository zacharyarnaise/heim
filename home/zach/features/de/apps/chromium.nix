{
  pkgs,
  lib,
  ...
}: let
  chromiumPkg = pkgs.ungoogled-chromium;

  createExtensionFor = browserVersion: {
    id,
    sha256,
    version,
  }: {
    inherit id;
    crxPath = builtins.fetchurl {
      url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
      name = "${id}.crx";
      inherit sha256;
    };
    inherit version;
  };
  createExtension = createExtensionFor (lib.versions.major chromiumPkg.version);
in {
  programs.chromium = {
    enable = true;

    package = chromiumPkg;

    commandLineArgs = [
      "--ozone-platform=wayland"
      "--ozone-platform-hint=auto"

      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
      "--enable-gpu-rasterization"

      "--disk-cache=$XDG_RUNTIME_DIR/chromium-cache" # cache in tmpfs

      "--disable-breakpad"
      "--disable-speech-api"
      "--disable-speech-synthesis-api"
      "--disable-sync"
      "--force-dark-mode"
      "--incognito"
      "--no-crash-upload"
      "--no-first-run"
      "--no-service-autorun"

      # ungoogled-chromium
      # https://github.com/ungoogled-software/ungoogled-chromium/blob/master/docs/flags.md
      "--disable-search-engine-collection"
      "--extension-mime-request-handling=always-prompt-for-install"
      "--fingerprinting-canvas-image-data-noise"
      "--fingerprinting-canvas-measuretext-noise"
      "--fingerprinting-client-rects-noise"
      "--force-punycode-hostnames"
      "--hide-crashed-bubble"

      "--bookmark-bar-ntp=never"
      "--close-confirmation=multiple"
      "--close-window-with-last-tab=never"
      "--custom-ntp=about:blank"
      "--disable-sharing-hub"
      "--remove-grab-handle"
      "--show-avatar-button=incognito-and-guest"

      "--disable-top-sites"
      "--no-default-browser-check"
      "--no-pings"

      "--enable-features=ClearDataOnExit,DisableQRGenerator,WebUIDarkMode"
    ];

    extensions = [
      # uBlock Origin
      (createExtension {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        sha256 = "sha256:1lnk0k8zy0w33cxpv93q1am0d7ds2na64zshvbwdnbjq8x4sw5p6";
        version = "1.63.2";
      })

      # Datadog test recorder
      (createExtension {
        id = "kkbncfpddhdmkfmalecgnphegacgejoa";
        sha256 = "sha256:0c1l8iii894ihig0a4hyn1b4pfpiaakrbjxl2sl2y3h6v5iz2ify";
        version = "3.8.2";
      })
    ];
  };
}
