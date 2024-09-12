let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  programs.firefox = {
    enable = true;
    languagePacks = ["en_US"];
    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      DisableAccounts = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableTelemetry = true;
      DisableFeedbackCommands = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DontCheckDefaultBrowser = true;
      ManualAppUpdateOnly = true;
      NoDefaultBookmarks = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      Extensions = {
        Install = ["https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"];
        Uninstall = ["amazondotcom@search.mozilla.org" "ebay@search.mozilla.org"];
      };
      #configure extensions
      #3rdparty = {
      #};
      ExtensionSettings = {
        "*".installation_mode = "blocked";
        "*".blocked_install_message = "Please, edit firefox.nix to manage extensions";
      };
      Preferences = {
        # https://github.com/yokoffing/Betterfox/
        # Last updated: 2024-09-12; FF 130
        # Fastfox
        "content.notify.interval" = {
          Value = 100000;
          Status = "locked";
        };
        "gfx.canvas.accelerated" = lock-true;
        "gfx.canvas.accelerated.cache-items" = {
          Value = 4096;
          Status = "locked";
        };
        "gfx.canvas.accelerated.cache-size" = {
          Value = 512;
          Status = "locked";
        };
        "gfx.content.skia-font-cache-size" = {
          Value = 20;
          Status = "locked";
        };
        "browser.cache.jsbc_compression_level" = {
          Value = 3;
          Status = "locked";
        };
        "browser.cache.memory.capacity" = {
          Value = -1;
          Status = "locked";
        };
        "browser.cache.memory.max_entry_size" = {
          Value = 10240;
          Status = "locked";
        };
        "media.memory_cache_max_size" = {
          Value = 65536;
          Status = "locked";
        };
        "image.mem.decode_bytes_at_a_time" = {
          Value = 32768;
          Status = "locked";
        };
        "network.http.max-connections" = {
          Value = 1800;
          Status = "locked";
        };
        "network.http.max-persistent-connections-per-server" = {
          Value = 10;
          Status = "locked";
        };
        "network.http.max-urgent-start-excessive-connections-per-host" = {
          Value = 5;
          Status = "locked";
        };
        "network.http.pacing.requests.enabled" = lock-false;
        "network.dnsCacheExpiration" = {
          Value = 3600;
          Status = "locked";
        };
        "network.ssl_tokens_cache_capacity" = {
          Value = 10240;
          Status = "locked";
        };
        "network.dns.disablePrefetch" = lock-true;
        "network.dns.disablePrefetchFromHTTPS" = lock-true;
        "network.prefetch-next" = lock-false;
        "network.predictor.enabled" = lock-false;
        # Securefox
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "privacy.query_stripping.strip_on_share.enabled" = lock-true;
        "urlclassifier.trackingSkipURLs" = {
          Value = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
          Status = "locked";
        };
        "urlclassifier.features.socialtracking.skipURLs" = {
          Value = "*.instagram.com, *.twitter.com, *.twimg.com";
          Status = "locked";
        };
        "privacy.bounceTrackingProtection.enabled" = lock-true;
        "privacy.bounceTrackingProtection.enableDryRunMode" = lock-false;
        "network.cookie.sameSite.noneRequiresSecure" = lock-true;
        "browser.download.start_downloads_in_tmp_dir" = lock-true;
        "browser.helperApps.deleteTempFileOnExit" = lock-true;
        "browser.uitour.enabled" = lock-false;
        "privacy.globalprivacycontrol.enabled" = lock-true;
        "security.OCSP.enabled" = {
          Value = 0;
          Status = "locked";
        };
        "security.remote_settings.crlite_filters.enabled" = lock-true;
        "security.pki.crlite_mode" = {
          Value = 2;
          Status = "locked";
        };
        "security.ssl.treat_unsafe_negotiation_as_broken" = lock-true;
        "browser.xul.error_pages.expert_bad_cert" = lock-true;
        "security.tls.enable_0rtt_data" = lock-false;
        "browser.privatebrowsing.forceMediaMemoryCache" = lock-true;
        "browser.sessionstore.interval" = {
          Value = 60000;
          Status = "locked";
        };
        "privacy.history.custom" = lock-true;
        "browser.urlbar.trimHttps" = lock-true;
        "browser.urlbar.untrimOnUserInteraction.featureGate" = lock-true;
        "security.insecure_connection_text.enabled" = lock-true;
        "security.insecure_connection_text.pbmode.enabled" = lock-true;
        "browser.urlbar.quicksuggest.enabled" = lock-false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = lock-false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = lock-false;
        "browser.urlbar.groupLabels.enabled" = lock-false;
        "network.dns.disableIPv6" = lock-true;
        "signon.formlessCapture.enabled" = lock-false;
        "signon.privateBrowsingCapture.enabled" = lock-false;
        "signon.generation.enabled" = lock-false;
        "signon.firefoxRelay.feature" = {
          Value = "";
          Status = "locked";
        };
        "network.auth.subresource-http-auth-allow" = {
          Value = 1;
          Status = "locked";
        };
        "editor.truncate_user_pastes" = lock-false;
        "extensions.formautofill.addresses.enabled" = lock-false;
        "extensions.formautofill.creditCards.enabled" = lock-false;
        "security.mixed_content.block_display_content" = lock-true;
        "pdfjs.enableScripting" = lock-false;
        "extensions.postDownloadThirdPartyPrompt" = lock-false;
        "browser.tabs.searchclipboardfor.middleclick" = lock-false;
        "network.http.referer.XOriginTrimmingPolicy" = {
          Value = 2;
          Status = "locked";
        };
        "privacy.userContext.ui.enabled" = lock-true;
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = lock-true;
        "media.peerconnection.ice.default_address_only" = lock-true;
        "browser.safebrowsing.downloads.remote.enabled" = lock-false;
        "accessibility.force_disabled" = {
          Value = 1;
          Status = "locked";
        };
        "identity.fxaccounts.enabled" = lock-false;
        "dom.push.enabled" = lock-false;
        "permissions.default.desktop-notification" = {
          Value = 2;
          Status = "locked";
        };
        "permissions.default.geo" = {
          Value = 2;
          Status = "locked";
        };
        "permissions.manager.defaultsUrl" = {
          Value = "";
          Status = "locked";
        };
        "webchannel.allowObject.urlWhitelist" = {
          Value = "";
          Status = "locked";
        };
        "datareporting.policy.dataSubmissionEnabled" = lock-false;
        "datareporting.healthreport.uploadEnabled" = lock-false;
        "toolkit.telemetry.unified" = lock-false;
        "toolkit.telemetry.enabled" = lock-false;
        "toolkit.telemetry.server" = {
          Value = "data:,";
          Status = "locked";
        };
        "toolkit.telemetry.archive.enabled" = lock-false;
        "toolkit.telemetry.newProfilePing.enabled" = lock-false;
        "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
        "toolkit.telemetry.updatePing.enabled" = lock-false;
        "toolkit.telemetry.bhrPing.enabled" = lock-false;
        "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
        "toolkit.telemetry.coverage.opt-out" = lock-true;
        "toolkit.coverage.opt-out" = lock-true;
        "toolkit.coverage.endpoint.base" = {
          Value = "";
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.feeds.telemetry" = lock-false;
        "browser.newtabpage.activity-stream.telemetry" = lock-false;
        "app.shield.optoutstudies.enabled" = lock-false;
        "app.normandy.enabled" = lock-false;
        "app.normandy.api_url" = {
          Value = "";
          Status = "locked";
        };
        "breakpad.reportURL" = {
          Value = "";
          Status = "locked";
        };
        "browser.tabs.crashReporting.sendReport" = lock-false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = lock-false;
        "captivedetect.canonicalURL" = {
          Value = "";
          Status = "locked";
        };
        "network.captive-portal-service.enabled" = lock-false;
        "extensions.abuseReport.enabled" = lock-false;
        "browser.search.serpEventTelemetryCategorization.enabled" = lock-false;
        # Peskyfox
        "browser.privatebrowsing.vpnpromourl" = {
          Value = "";
          Status = "locked";
        };
        "browser.vpn_promo.enabled" = lock-false;
        "extensions.getAddons.showPane" = lock-false;
        "extensions.htmlaboutaddons.recommendations.enabled" = lock-false;
        "browser.discovery.enabled" = lock-false;
        "browser.shell.checkDefaultBrowser" = lock-false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = lock-false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = lock-false;
        "browser.preferences.moreFromMozilla" = lock-false;
        "browser.aboutConfig.showWarning" = lock-false;
        "browser.aboutwelcome.enabled" = lock-false;
        "browser.messaging-system.whatsNewPanel.enabled" = lock-false;
        "browser.tabs.tabmanager.enabled" = lock-false;
        "browser.profiles.enabled" = lock-true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = lock-true;
        "browser.compactmode.show" = lock-true;
        "browser.display.focus_ring_on_anything" = lock-true;
        "browser.display.focus_ring_style" = {
          Value = 0;
          Status = "locked";
        };
        "browser.display.focus_ring_width" = {
          Value = 0;
          Status = "locked";
        };
        "browser.translations.enable" = lock-false;
        "gfx.webrender.quality.force-subpixel-aa-where-possible" = lock-true;
        "browser.urlbar.suggest.engines" = lock-false;
        "browser.urlbar.suggest.calculator" = lock-true;
        "browser.urlbar.unitConversion.enabled" = lock-true;
        "browser.urlbar.trending.featureGate" = lock-false;
        "browser.startup.page" = {
          Value = 3;
          Status = "locked";
        };
        "browser.startup.homepage" = {
          Value = "about:blank";
          Status = "locked";
        };
        "browser.newtabpage.enabled" = lock-false;
        "browser.newtabpage.activity-stream.feeds.topsites" = lock-false;
        "browser.newtabpage.activity-stream.showWeather" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
        "browser.newtabpage.activity-stream.default.sites" = {
          Value = "";
          Status = "locked";
        };
        "extensions.pocket.enabled" = lock-false;
        "browser.download.always_ask_before_handling_new_types" = lock-false;
        "browser.download.useDownloadDir" = lock-false;
        "browser.download.manager.addToRecentDocs" = lock-false;
        "browser.download.open_pdf_attachments_inline" = lock-true;
        "pdfjs.sidebarViewOnLoad" = {
          Value = 2;
          Status = "locked";
        };
        "browser.tabs.loadBookmarksInTabs" = lock-true;
        "browser.menu.showViewImageInfo" = lock-true;
        "findbar.highlightAll" = lock-true;
        "middlemouse.contentLoadURL" = lock-false;
        "dom.disable_window_move_resize" = lock-true;
        "browser.tabs.closeWindowWithLastTab" = lock-false;
        "layout.word_select.eat_space_to_next_word" = lock-false;
        "browser.tabs.hoverPreview.enabled" = lock-true;
        "ui.key.menuAccessKeyFocuses" = lock-false;
        "reader.parse-on-load.enabled" = lock-false;
        "layout.css.moz-document.content.enabled" = lock-true;
        # Smoothfox
        "apz.overscroll.enabled" = lock-true;
        "general.smoothScroll" = lock-true;
        "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = {
          Value = 12;
          Status = "locked";
        };
        "general.smoothScroll.msdPhysics.enabled" = lock-true;
        "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = {
          Value = 600;
          Status = "locked";
        };
        "general.smoothScroll.msdPhysics.regularSpringConstant" = {
          Value = 650;
          Status = "locked";
        };
        "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = {
          Value = 25;
          Status = "locked";
        };
        "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = {
          Value = "2";
          Status = "locked";
        };
        "general.smoothScroll.msdPhysics.slowdownSpringConstant" = {
          Value = 250;
          Status = "locked";
        };
        "general.smoothScroll.currentVelocityWeighting" = {
          Value = "1";
          Status = "locked";
        };
        "general.smoothScroll.stopDecelerationWeighting" = {
          Value = "1";
          Status = "locked";
        };
        "mousewheel.default.delta_multiplier_y" = {
          Value = 300;
          Status = "locked";
        };
      };
      SearchEngines = {
        PreventInstalls = true;
        Remove = ["Amazon.com" "eBay"];
        Default = "DuckDuckGo";
      };
    };
  };
}
