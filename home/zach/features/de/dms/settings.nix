{
  config,
  lib,
  ...
}: let
  idleTimeout =
    if config.hostSpec.kind == "laptop"
    then 300
    else 900;
in {
  widgetColorMode = "default";
  popupTransparency = 0.75;
  dockTransparency = 0.6;
  widgetBackgroundColor = "sc";
  controlCenterTileColorMode = "primary";
  buttonColorMode = "primary";
  cornerRadius = 16;
  use24HourClock = true;
  showSeconds = true;
  padHours12Hour = false;
  useFahrenheit = false;
  windSpeedUnit = "kmh";
  nightModeEnabled = true;
  animationSpeed = 1;
  customAnimationDuration = 500;
  syncComponentAnimationSpeeds = false;
  popoutAnimationSpeed = 2;
  popoutCustomAnimationDuration = 150;
  modalAnimationSpeed = 1;
  modalCustomAnimationDuration = 150;
  enableRippleEffects = true;
  blurEnabled = false;
  showLauncherButton = true;
  showWorkspaceSwitcher = true;
  showFocusedWindow = false;
  showWeather = true;
  showMusic = true;
  showClipboard = false;
  showCpuUsage = true;
  showMemUsage = true;
  showCpuTemp = true;
  showGpuTemp = false;
  showSystemTray = true;
  systemTrayIconTintMode = "none";
  showClock = true;
  showNotificationButton = true;
  showBattery = true;
  showControlCenterButton = true;
  showCapsLockIndicator = false;
  controlCenterShowNetworkIcon = true;
  controlCenterShowBluetoothIcon = true;
  controlCenterShowAudioIcon = true;
  controlCenterShowAudioPercent = true;
  controlCenterShowVpnIcon = true;
  controlCenterShowMicIcon = true;
  controlCenterShowMicPercent = true;
  controlCenterShowBrightnessIcon = false;
  controlCenterShowBrightnessPercent = false;
  controlCenterShowBatteryIcon = false;
  controlCenterShowPrinterIcon = false;
  controlCenterShowScreenSharingIcon = false;
  showPrivacyButton = true;
  privacyShowMicIcon = false;
  privacyShowCameraIcon = false;
  privacyShowScreenShareIcon = false;
  controlCenterWidgets = [
    {
      id = "audioOutput";
      enabled = true;
      width = 50;
    }
    {
      id = "audioInput";
      enabled = true;
      width = 50;
    }
    {
      id = "wifi";
      enabled = true;
      width = 50;
    }
    {
      id = "bluetooth";
      enabled = true;
      width = 50;
    }
    {
      id = "nightMode";
      enabled = true;
      width = 50;
    }
    {
      id = "darkMode";
      enabled = true;
      width = 50;
    }
    {
      id = "brightnessSlider";
      enabled = true;
      width = 100;
    }
  ];
  showWorkspaceIndex = false;
  showWorkspaceName = true;
  showWorkspacePadding = true;
  workspaceScrolling = false;
  showWorkspaceApps = true;
  workspaceDragReorder = true;
  maxWorkspaceIcons = 4;
  workspaceAppIconSizeOffset = 1;
  groupWorkspaceApps = true;
  workspaceFollowFocus = true;
  showOccupiedWorkspacesOnly = true;
  reverseScrolling = false;
  dwlShowAllTags = false;
  workspaceColorMode = "default";
  workspaceOccupiedColorMode = "none";
  workspaceUnfocusedColorMode = "s";
  workspaceUrgentColorMode = "default";
  workspaceFocusedBorderEnabled = false;
  waveProgressEnabled = true;
  scrollTitleEnabled = false;
  audioVisualizerEnabled = true;
  audioScrollMode = "volume";
  audioWheelScrollAmount = 5;
  clockCompactMode = false;
  focusedWindowCompactMode = false;
  runningAppsCompactMode = true;
  barMaxVisibleApps = 0;
  barMaxVisibleRunningApps = 0;
  barShowOverflowBadge = true;
  appsDockHideIndicators = false;
  appsDockColorizeActive = false;
  appsDockActiveColorMode = "primary";
  appsDockEnlargeOnHover = false;
  appsDockEnlargePercentage = 125;
  appsDockIconSizePercentage = 100;
  keyboardLayoutNameCompactMode = false;
  runningAppsCurrentWorkspace = true;
  runningAppsGroupByApp = false;
  runningAppsCurrentMonitor = false;
  appIdSubstitutions = [];
  centeringMode = "index";
  clockDateFormat = "";
  lockDateFormat = "";
  mediaSize = 1;
  appLauncherViewMode = "list";
  spotlightModalViewMode = "list";
  browserPickerViewMode = "grid";
  appPickerViewMode = "grid";
  sortAppsAlphabetically = true;
  appLauncherGridColumns = 5;
  spotlightCloseNiriOverview = true;
  spotlightSectionViewModes.apps = "list";
  appDrawerSectionViewModes = {};
  dankLauncherV2Size = "compact";
  dankLauncherV2BorderEnabled = false;
  dankLauncherV2ShowFooter = false;
  dankLauncherV2UnloadOnClose = false;
  useAutoLocation = false;
  weatherEnabled = true;
  launcherLogoMode = "os";
  launcherLogoBrightness = 0.5;
  launcherLogoContrast = 1;
  launcherLogoSizeOffset = 2;
  fontFamily = lib.mkForce "Inter Display";
  fontWeight = 400;
  fontScale = 1;
  notepadUseMonospace = true;
  notepadFontSize = 14;
  notepadShowLineNumbers = true;
  soundsEnabled = false;
  acMonitorTimeout = idleTimeout + 300;
  acLockTimeout = idleTimeout;
  acSuspendTimeout = 0;
  acSuspendBehavior = 0;
  batteryMonitorTimeout = idleTimeout;
  batteryLockTimeout = idleTimeout;
  batterySuspendTimeout = 0;
  batterySuspendBehavior = 0;
  batteryChargeLimit = 100;
  lockBeforeSuspend = true;
  loginctlLockIntegration = true;
  fadeToLockEnabled = true;
  fadeToLockGracePeriod = 5;
  fadeToDpmsEnabled = true;
  fadeToDpmsGracePeriod = 5;
  launchPrefix = "";
  muxType = "tmux";
  muxUseCustomCommand = false;
  runDmsMatugenTemplates = true;
  showDock = false;
  notificationOverlayEnabled = false;
  notificationPopupShadowEnabled = true;
  notificationPopupPrivacyMode = false;
  modalDarkenBackground = true;
  lockScreenShowPowerActions = true;
  lockScreenShowSystemIcons = true;
  lockScreenShowTime = true;
  lockScreenShowDate = true;
  lockScreenShowProfileImage = false;
  lockScreenShowPasswordField = true;
  lockScreenShowMediaPlayer = false;
  lockScreenPowerOffMonitorsOnLock = false;
  lockAtStartup = false;
  enableFprint = false;
  maxFprintTries = 15;
  enableU2f = true;
  u2fMode = "or";
  lockScreenActiveMonitor = config.primaryMonitor.name;
  lockScreenInactiveColor = "#000000";
  lockScreenNotificationMode = 1;
  hideBrightnessSlider = false;
  notificationTimeoutLow = 5000;
  notificationTimeoutNormal = 8000;
  notificationTimeoutCritical = 0;
  notificationCompactMode = true;
  notificationPopupPosition = 0;
  notificationAnimationSpeed = 1;
  notificationCustomAnimationDuration = 400;
  notificationHistoryEnabled = true;
  notificationHistoryMaxCount = 50;
  notificationHistoryMaxAgeDays = 1;
  notificationHistorySaveLow = true;
  notificationHistorySaveNormal = true;
  notificationHistorySaveCritical = true;
  notificationRules = [
    {
      enabled = true;
      field = "appName";
      pattern = "yubikey-touch-detector";
      matchType = "exact";
      action = "no_history";
      urgency = "critical";
    }
  ];
  osdAlwaysShowValue = true;
  osdPosition = 5;
  osdVolumeEnabled = true;
  osdMediaVolumeEnabled = true;
  osdMediaPlaybackEnabled = true;
  osdBrightnessEnabled = true;
  osdIdleInhibitorEnabled = false;
  osdMicMuteEnabled = true;
  osdCapsLockEnabled = true;
  osdPowerProfileEnabled = false;
  osdAudioOutputEnabled = false;
  powerActionConfirm = true;
  powerActionHoldDuration = 0.5;
  powerMenuActions = [
    "reboot"
    "logout"
    "poweroff"
    "lock"
    "suspend"
    "restart"
  ];
  powerMenuDefaultAction = "lock";
  powerMenuGridLayout = false;
  displayNameMode = "system";
  screenPreferences = {
    dock = [{name = config.primaryMonitor.name;}];
    notifications = [{name = config.primaryMonitor.name;}];
    osd = [{name = config.primaryMonitor.name;}];
    wallpaper = [];
  };
  showOnLastDisplay = {
    dock = true;
    notifications = true;
    osd = true;
  };
  displayProfileAutoSelect = false;
  displayShowDisconnected = false;
  displaySnapToEdge = true;
  barConfigs = [
    {
      id = "default";
      name = "Main Bar";
      enabled = true;
      position = 0;
      screenPreferences = [{name = config.primaryMonitor.name;}];
      showOnLastDisplay = true;
      leftWidgets = [
        {
          id = "launcherButton";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
          size = 20;
        }
        {
          id = "cpuUsage";
          enabled = true;
          minimumWidth = true;
        }
        {
          id = "cpuTemp";
          enabled = true;
          minimumWidth = true;
        }
        {
          id = "memUsage";
          enabled = true;
          minimumWidth = true;
        }
        {
          id = "battery";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
          size = 20;
        }
        {
          id = "music";
          enabled = true;
          mediaSize = 2;
        }
      ];
      centerWidgets = [
        {
          id = "workspaceSwitcher";
          enabled = true;
        }
      ];
      rightWidgets = [
        {
          id = "systemTray";
          enabled = true;
        }
        {
          id = "notificationButton";
          enabled = true;
        }
        {
          id = "idleInhibitor";
          enabled = true;
        }
        {
          id = "controlCenterButton";
          enabled = true;
          showNetworkIcon = true;
          showBluetoothIcon = true;
          showAudioIcon = true;
          showAudioPercent = true;
          showVpnIcon = true;
          showBrightnessIcon = false;
          showBrightnessPercent = false;
          showMicIcon = true;
          showMicPercent = true;
          showBatteryIcon = false;
          showPrinterIcon = false;
          showScreenSharingIcon = false;
        }
        {
          id = "spacer";
          enabled = true;
          size = 20;
        }
        {
          id = "clock";
          enabled = true;
          clockCompactMode = false;
        }
        {
          id = "weather";
          enabled = true;
        }
        {
          id = "privacyIndicator";
          enabled = true;
        }
      ];
      spacing = 0;
      innerPadding = 5;
      bottomGap = -6;
      transparency = 0;
      widgetTransparency = 0.75;
      squareCorners = false;
      noBackground = false;
      fontScale = 1;
      autoHide = false;
      visible = true;
      popupGapsAuto = false;
      popupGapsManual = 0;
      widgetPadding = 5;
      iconScale = 1.1;
      widgetOutlineEnabled = true;
      widgetOutlineThickness = 1;
      widgetOutlineOpacity = 0.4;
      widgetOutlineColor = "primary";
      shadowIntensity = 0;
    }
  ];
  desktopClockEnabled = false;
  systemMonitorEnabled = false;
  desktopWidgetPositions = {};
  desktopWidgetGridSettings = {};
  desktopWidgetInstances = [];
  desktopWidgetGroups = [];
  builtInPluginSettings = {
    dms_settings_search = {
      trigger = "?";
      enabled = false;
    };
    dms_notepad = {
      enabled = false;
    };
    dms_sysmon = {
      enabled = false;
    };
    dms_settings = {
      enabled = false;
    };
  };
  clipboardEnterToPaste = false;
  launcherPluginVisibility = {};
  launcherPluginOrder = [];
  configVersion = 5;
}
