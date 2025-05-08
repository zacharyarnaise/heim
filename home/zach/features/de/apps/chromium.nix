{pkgs, ...}: {
  programs.chromium = {
    enable = true;

    package = pkgs.ungoogled-chromium;

    commandLineArgs = [
      "--ozone-platform=wayland"
      "--ozone-platform-hint=auto"

      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
      "--enable-gpu-rasterization"
      "--enable-oop-rasterization"

      "--disk-cache=$XDG_RUNTIME_DIR/chromium-cache" # cache in tmpfs

      "--disable-breakpad"
      "--disable-speech-api"
      "--disable-speech-synthesis-api"
      "--disable-sync"
      "--disable-wake-on-wifi"
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

      "--enable-features=ClearDataOnExit,DisableQRGenerator"
    ];

    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
      {id = "kkbncfpddhdmkfmalecgnphegacgejoa";} # Datadog test recorder
    ];
  };
}
