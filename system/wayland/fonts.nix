{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      iosevka-bin
      lexend
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["Iosevka"})
    ];

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        monospace = [
          "Iosevka Term"
          "Iosevka Term Nerd Font Complete Mono"
          "Iosevka Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Lexend" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
