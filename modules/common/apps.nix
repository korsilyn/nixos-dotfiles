{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
