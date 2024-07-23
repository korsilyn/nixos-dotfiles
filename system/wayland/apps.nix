{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox

    _64gram
    vesktop

    keepassxc

    zip
    unzip
  ];
}
