{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  imports = [
    ./gaming.nix
  ];

  options.modules.system.programs = {
    gui.enable = mkEnableOption "GUI package sets" // {default = true;};
    cli.enable = mkEnableOption "CLI package sets" // {default = true;};

    vesktop.enable = mkEnableOption "Vesktop client";
    telegram.enable = mkEnableOption "64Gram client";
    libreoffice.enable = mkEnableOption "LibreOffice suite";
    obs.enable = mkEnableOption "OBS Studio";
    vscode.enable = mkEnableOption "Visual Studio Code";
    steam.enable = mkEnableOption "Steam game client";
    zathura.enable = mkEnableOption "Zathura document viewer";
    rnnoise.enable = mkEnableOption "RNNoise noise suppression plugin";

    firefox = {
      enable = mkEnableOption "Firefox browser";
      schizofox.enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Schizofox Firefox Tweaks";
      };
    };

    editors = {
      neovim.enable = mkEnableOption "Neovim text editor";
    };

    terminals = {
      kitty.enable = mkEnableOption "Kitty terminal emulator";
    };

    git = {
      signingKey = mkOption {
        type = types.str;
        default = "";
        description = "The default gpg key used for signing commits";
      };
    };

    # default program options
    default = {
      # what program should be used as the default terminal
      terminal = mkOption {
        type = types.enum ["kitty"];
        default = "kitty";
      };

      fileManager = mkOption {
        type = types.enum ["thunar" "dolphin" "nemo"];
        default = "thunar";
      };

      browser = mkOption {
        type = types.enum ["firefox" "librewolf" "chromium"];
        default = "firefox";
      };

      editor = mkOption {
        type = types.enum ["neovim" "helix" "emacs"];
        default = "neovim";
      };

      launcher = mkOption {
        type = types.enum ["rofi" "wofi" "anyrun" "fuzzel"];
        default = "fuzzel";
      };
    };
  };
}
