{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox

    _64gram
    vesktop

    keepassxc

    zip
    unzip

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
