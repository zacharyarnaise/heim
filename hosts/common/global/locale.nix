{
  config,
  lib,
  ...
}: {
  console.keyMap = config.hostSpec.keyboard.layout;
  time.timeZone = "Europe/Paris";

  i18n = {
    defaultLocale = lib.mkDefault "fr_FR.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = lib.mkDefault "en_US.UTF-8";
    };
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
    ];
  };
}
