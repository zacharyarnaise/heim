{pkgs, ...}: let
  package = pkgs.ungoogled-chromium;
in {
  programs.chromium = {
    enable = true;
    inherit package;

    commandLineArgs =
      [
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
        "--disable-sharing-hub"
        "--remove-grab-handle"
        "--show-avatar-button=incognito-and-guest"

        "--disable-top-sites"
        "--no-default-browser-check"
        "--no-pings"

        "--enable-features=ClearDataOnExit,DisableQRGenerator,WebUIDarkMode"
      ]
      ++ map (extensionID: "https://clients2.google.com/service/update2/crx?response=redirect\\&acceptformat=crx2,crx3\\&prodversion=${package.version}\\&x=id%3D${extensionID}%26installsource%3Dondemand%26uc") [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        "kkbncfpddhdmkfmalecgnphegacgejoa" # Datadog test recorder
      ];
  };
}
