{
  self',
  inputs,
  osConfig,
  lib,
  ...
}: let
  inherit (builtins) listToAttrs;
  inherit (lib.modules) mkIf;
  inherit (osConfig) modules;

  sys = modules.system;
  prg = sys.programs;
in {
  imports = [inputs.schizofox.homeManagerModule];
  config = mkIf prg.firefox.enable {
    programs.schizofox = {
      enable = true;

      theme = {
        font = "Comfortaa";
        colors = {
          background-darker = "181825";
          background = "1e1e2e";
          foreground = "cdd6f4";
        };
      };

      search = rec {
        defaultSearchEngine = "DuckDuckGo";
        removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia" "LibRedirect"];
      };

      security = {
        sanitizeOnShutdown = false;
        sandbox = true;
        noSessionRestore = false;
        userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
      };

      misc = {
        drm.enable = true;
        disableWebgl = false;
        bookmarks = [
        ];
      };

      extensions = {
        simplefox.enable = true;

        enableDefaultExtensions = true;
        enableExtraExtensions = true;
        extraExtensions = let
          extensions = [
            {
              id = "sponsorBlocker@ajay.app";
              name = "sponsorblock";
            }
            {
              id = "{74145f27-f039-47ce-a470-a662b129930a}";
              name = "clearurls";
            }
            {
              id = "skipredirect@sblask";
              name = "skip-redirect";
            }
          ];

          mappedExtensions =
            map (extension: {
              name = extension.id;
              value = {
                # installation_mode = "force_installed";
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/${extension.name}/latest.xpi";
              };
            })
            extensions;
        in
          listToAttrs mappedExtensions;
      };
    };
  };
}
