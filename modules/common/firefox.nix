{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
    languagePacks = ["en-US"];
    policies = {
      # Configure extensions
      #3rdparty = {};
      DisableAccounts = true;
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableMasterPasswordCreation = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = true;
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      HardwareAcceleration = true;
      Homepage = {
        StartPage = "previous-session";
        Locked = true;
      };
      HttpsOnlyMode = "enabled";
      NetworkPrediction = false;
      NewTabPage = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;
      PDFjs = {
        Enabled = true;
        EnablePermissions = false;
      };
      Permissions = {
        Location = {
          BlockNewRequests = true;
          Locked = true;
        };
        Notifications = {
          BlockNewRequests = true;
          Locked = true;
        };
      };
      PromptForDownloadLocation = true;
      TranslateEnabled = false;
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = false;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = true;
      };
      Extensions = {
        Uninstall = ["amazondotcom@search.mozilla.org" "ebay@search.mozilla.org"];
      };
      ExtensionSettings = {
        "*".installation_mode = "blocked";
        "*".blocked_install_message = "Please, edit firefox.nix to manage extensions";
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      SearchEngines = {
        PreventInstalls = true;
        Remove = ["Amazon.com" "eBay"];
        Default = "DuckDuckGo";
      };
      Preferences = {
        "extensions.htmlaboutaddons.recommendations.enabled" = {
          Value = false;
          Status = "locked";
        };
      };
    };
  };
}
