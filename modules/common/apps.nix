{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    direnv

    firefox

    _64gram
    vesktop

    keepassxc

    zip
    unzip
    p7zip

    bat
    eza
    dust
    duf
    fd
    ripgrep
    sd
    cht-sh
    glances
    curlie
  ];
}
