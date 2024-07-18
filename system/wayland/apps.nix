{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox

    tdesktop
    vesktop

    keepassxc
  ];
}
