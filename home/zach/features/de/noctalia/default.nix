{
  inputs,
  config,
  lib,
  ...
}: let
  idleTimeout =
    if config.hostSpec.kind == "laptop"
    then 300
    else 900;
in {
  imports = [
    inputs.noctalia.homeModules.default
    ./plugins.nix
  ];

  home.file.".cache/noctalia/shell-state.json".text = lib.generators.toJSON {} {
    changelogState.lastSeenVersion = "";
    telemetry.instanceId = "";
  };
  home.persistence."/persist" = {
    directories = [
      ".config/noctalia/plugins"
    ];
  };

  programs.noctalia-shell = {
    enable = true;

    settings = {
      settingsVersion = 59;
      appLauncher = {
        autoPasteClipboard = false;
        clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
        clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
        clipboardWrapText = true;
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        density = "compact";
        enableClipPreview = true;
        enableClipboardChips = true;
        enableClipboardHistory = true;
        enableClipboardSmartIcons = true;
        enableSessionSearch = false;
        enableSettingsSearch = false;
        enableWindowsSearch = false;
        iconMode = "tabler";
        ignoreMouseInput = false;
        overviewLayer = false;
        pinnedApps = [];
        position = "follow_bar";
        screenshotAnnotationTool = "";
        showCategories = true;
        showIconBackground = false;
        sortByMostUsed = false;
        terminalCommand = "";
        viewMode = "grid";
      };
      audio = {
        mprisBlacklist = [];
        preferredPlayer = "";
        spectrumFrameRate = 30;
        spectrumMirrored = false;
        visualizerType = "linear";
        volumeFeedback = false;
        volumeFeedbackSoundFile = "";
        volumeOverdrive = false;
        volumeStep = 5;
      };
      bar = {
        autoHideDelay = 500;
        autoShowDelay = 150;
        backgroundOpacity = 0.6;
        barType = "simple";
        capsuleColorKey = "none";
        capsuleOpacity = lib.mkForce 0.5;
        contentPadding = 0;
        density = "comfortable";
        displayMode = "always_visible";
        enableExclusionZoneInset = true;
        fontScale = 0.9;
        frameRadius = 12;
        frameThickness = 8;
        hideOnOverview = false;
        marginHorizontal = 4;
        marginVertical = 4;
        middleClickAction = "launcherPanel";
        middleClickCommand = "";
        middleClickFollowMouse = false;
        monitors = [config.primaryMonitor.name];
        mouseWheelAction = "workspace";
        mouseWheelWrap = true;
        outerCorners = true;
        position = "top";
        reverseScroll = false;
        rightClickAction = "controlCenter";
        rightClickCommand = "";
        rightClickFollowMouse = true;
        screenOverrides = [
          {
            enabled = false;
            name = config.primaryMonitor.name;
          }
        ];
        showCapsule = true;
        showOnWorkspaceSwitch = true;
        showOutline = false;
        useSeparateOpacity = false;
        widgetSpacing = 1;
        widgets = {
          center = [
            {
              characterCount = 2;
              colorizeIcons = false;
              emptyColor = "none";
              enableScrollWheel = true;
              focusedColor = "primary";
              followFocusedScreen = true;
              fontWeight = "bold";
              groupedBorderOpacity = 0.75;
              hideUnoccupied = false;
              iconScale = 0.8;
              id = "Workspace";
              labelMode = "index";
              occupiedColor = "tertiary";
              pillSize = 0.7;
              showApplications = true;
              showApplicationsHover = false;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 0.75;
            }
          ];
          left = [
            {
              colorizeSystemIcon = "none";
              colorizeSystemText = "none";
              customIconPath = "";
              enableColorization = true;
              icon = "rocket";
              iconColor = "none";
              id = "Launcher";
              useDistroLogo = true;
            }
            {
              id = "Spacer";
              width = 15;
            }
            {
              compactMode = false;
              diskPath = "/";
              iconColor = "none";
              id = "SystemMonitor";
              showCpuCores = false;
              showCpuFreq = false;
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskAvailable = false;
              showDiskUsage = false;
              showDiskUsageAsPercent = false;
              showGpuTemp = false;
              showLoadAverage = false;
              showMemoryAsPercent = false;
              showMemoryUsage = true;
              showNetworkStats = false;
              showSwapUsage = false;
              textColor = "none";
              useMonospaceFont = true;
              usePadding = true;
            }
            {
              id = "Spacer";
              width = 15;
            }
            {
              compactMode = true;
              hideMode = "hidden";
              hideWhenIdle = false;
              id = "MediaMini";
              maxWidth = 330;
              panelShowAlbumArt = true;
              scrollingMode = "hover";
              showAlbumArt = false;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = true;
              textColor = "none";
              useFixedWidth = false;
              visualizerType = "linear";
            }
          ];
          right = [
            {
              blacklist = [];
              chevronColor = "none";
              colorizeIcons = false;
              drawerEnabled = true;
              hidePassive = false;
              id = "Tray";
              pinned = [];
            }
            {
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              iconColor = "none";
              id = "NotificationHistory";
              showUnreadBadge = true;
              unreadBadgeColor = "secondary";
            }
            {
              iconColor = "none";
              id = "KeepAwake";
              textColor = "none";
            }
            {
              id = "Spacer";
              width = 15;
            }
            {
              deviceNativePath = "__default__";
              displayMode = "graphic-clean";
              hideIfIdle = false;
              hideIfNotDetected = true;
              id = "Battery";
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
            }
            {
              displayMode = "alwaysShow";
              iconColor = "none";
              id = "Volume";
              middleClickCommand = "pwvucontrol -t 1";
              textColor = "none";
            }
            {
              displayMode = "alwaysShow";
              iconColor = "none";
              id = "Microphone";
              middleClickCommand = "pwvucontrol -t 2";
              textColor = "none";
            }
            {
              applyToAllMonitors = true;
              displayMode = "onhover";
              iconColor = "none";
              id = "Brightness";
              textColor = "none";
            }
            {
              id = "Spacer";
              width = 15;
            }
            {
              clockColor = "none";
              customFont = "";
              formatHorizontal = "HH:mm:ss - ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              id = "Clock";
              tooltipFormat = "";
              useCustomFont = false;
            }
          ];
        };
      };
      brightness = {
        backlightDeviceMappings = [];
        brightnessStep = 5;
        enableDdcSupport = true;
        enforceMinimum = true;
      };
      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
        ];
      };
      colorSchemes = {
        darkMode = true;
        generationMethod = "rainbow";
        manualSunrise = "07:00";
        manualSunset = "19:00";
        monitorForColors = config.primaryMonitor.name;
        schedulingMode = "off";
        syncGsettings = true;
        useWallpaperColors = false;
      };
      controlCenter = {
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = true;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
        diskPath = "/";
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "NoctaliaPerformance";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
      };
      desktopWidgets = {
        enabled = false;
        monitorWidgets = [{name = config.primaryMonitor.name;}];
      };
      dock = {
        enabled = false;
      };
      general = {
        allowPanelsOnScreenWithoutBar = true;
        allowPasswordWithFprintd = false;
        animationDisabled = true;
        animationSpeed = 1;
        autoStartAuth = false;
        avatarImage = "";
        boxRadiusRatio = 1;
        clockFormat = "hh\\nmm";
        clockStyle = "custom";
        compactLockScreen = true;
        dimmerOpacity = 0.25;
        enableBlurBehind = false;
        enableLockScreenCountdown = true;
        enableLockScreenMediaControls = false;
        enableShadows = false;
        forceBlackScreenCorners = false;
        iRadiusRatio = 1;
        keybinds = {
          keyDown = ["Down"];
          keyEnter = [
            "Return"
            "Enter"
          ];
          keyEscape = ["Esc"];
          keyLeft = ["Left"];
          keyRemove = ["Del"];
          keyRight = ["Right"];
          keyUp = ["Up"];
        };
        language = "";
        lockOnSuspend = true;
        lockScreenAnimations = true;
        lockScreenBlur = 0;
        lockScreenCountdownDuration = 10000;
        lockScreenMonitors = [config.primaryMonitor.name];
        lockScreenTint = 0;
        passwordChars = true;
        radiusRatio = 1;
        reverseScroll = false;
        scaleRatio = 1;
        screenRadiusRatio = 1;
        shadowDirection = "center";
        shadowOffsetX = 0;
        shadowOffsetY = 0;
        showChangelogOnStartup = true;
        showHibernateOnLockScreen = false;
        showScreenCorners = false;
        showSessionButtonsOnLockScreen = false;
        smoothScrollEnabled = false;
        telemetryEnabled = false;
      };
      hooks = {
        enabled = false;
      };
      idle = {
        customCommands = "[]";
        enabled = true;
        fadeDuration = 10;
        lockCommand = "";
        lockTimeout = idleTimeout;
        resumeLockCommand = "";
        resumeScreenOffCommand = "";
        resumeSuspendCommand = "";
        screenOffCommand = "";
        screenOffTimeout = idleTimeout + 60;
        suspendCommand = "";
        suspendTimeout = 0;
      };
      location = {
        analogClockInCalendar = true;
        autoLocate = false;
        firstDayOfWeek = 1;
        hideWeatherCityName = true;
        hideWeatherTimezone = true;
        name = inputs.secrets.users.zach.noctalia.location;
        showCalendarEvents = true;
        showCalendarWeather = true;
        showWeekNumberInCalendar = true;
        use12hourFormat = false;
        useFahrenheit = false;
        weatherEnabled = true;
        weatherShowEffects = true;
        weatherTaliaMascotAlways = false;
      };
      network = {
        bluetoothAutoConnect = true;
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
        bluetoothRssiPollIntervalMs = 60000;
        bluetoothRssiPollingEnabled = false;
        disableDiscoverability = true;
        networkPanelView = "wifi";
        wifiDetailsViewMode = "grid";
      };
      nightLight = {
        autoSchedule = true;
        dayTemp = "6500";
        enabled = true;
        forced = false;
        manualSunrise = "07:00";
        manualSunset = "19:00";
        nightTemp = "3500";
      };
      noctaliaPerformance = {
        disableDesktopWidgets = true;
        disableWallpaper = true;
      };
      notifications = {
        backgroundOpacity = lib.mkForce 0.5;
        clearDismissed = true;
        criticalUrgencyDuration = 30;
        density = "default";
        enableBatteryToast = true;
        enableKeyboardLayoutToast = false;
        enableMarkdown = true;
        enableMediaToast = false;
        enabled = true;
        location = "top_right";
        lowUrgencyDuration = 4;
        monitors = [config.primaryMonitor.name];
        normalUrgencyDuration = 8;
        overlayLayer = true;
        respectExpireTimeout = false;
        saveToHistory = {
          critical = true;
          low = false;
          normal = true;
        };
        sounds = {
          criticalSoundFile = "";
          enabled = false;
          excludedApps = "discord,firefox,chrome,chromium,edge";
          lowSoundFile = "";
          normalSoundFile = "";
          separateSounds = false;
          volume = 0.5;
        };
      };
      osd = {
        autoHideMs = 2000;
        backgroundOpacity = lib.mkForce 0.5;
        enabled = true;
        enabledTypes = [
          0
          1
          2
          3
        ];
        location = "top_right";
        monitors = [config.primaryMonitor.name];
        overlayLayer = true;
      };
      plugins = {
        autoUpdate = false;
        notifyUpdates = false;
      };
      sessionMenu = {
        countdownDuration = 3000;
        enableCountdown = true;
        largeButtonsLayout = "single-row";
        largeButtonsStyle = true;
        position = "center";
        powerOptions = [
          {
            action = "lock";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "2";
          }
          {
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "3";
          }
          {
            action = "hibernate";
            command = "";
            countdownEnabled = true;
            enabled = false;
            keybind = "";
          }
          {
            action = "shutdown";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "4";
          }
          {
            action = "userspaceReboot";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "5";
          }
          {
            action = "reboot";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "6";
          }
          {
            action = "rebootToUefi";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "7";
          }
        ];
        showHeader = true;
        showKeybinds = true;
      };
      systemMonitor = {
        batteryCriticalThreshold = 5;
        batteryWarningThreshold = 20;
        cpuCriticalThreshold = 90;
        cpuWarningThreshold = 80;
        criticalColor = "#f38ba8";
        diskAvailCriticalThreshold = 10;
        diskAvailWarningThreshold = 20;
        diskCriticalThreshold = 90;
        diskWarningThreshold = 80;
        enableDgpuMonitoring = false;
        externalMonitor = "";
        gpuCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        memCriticalThreshold = 90;
        memWarningThreshold = 80;
        swapCriticalThreshold = 90;
        swapWarningThreshold = 80;
        tempCriticalThreshold = 90;
        tempWarningThreshold = 80;
        useCustomColors = false;
        warningColor = "#94e2d5";
      };
      templates = {
        activeTemplates = [];
        enableUserTheming = false;
      };
      ui = {
        boxBorderEnabled = false;
        fontDefault = lib.mkForce "Inter Display";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        panelBackgroundOpacity = lib.mkForce 0.4;
        panelsAttachedToBar = true;
        scrollbarAlwaysVisible = true;
        settingsPanelMode = "attached";
        settingsPanelSideBarCardStyle = false;
        tooltipsEnabled = true;
        translucentWidgets = false;
      };
      wallpaper = {
        automationEnabled = false;
      };
    };
  };
}
