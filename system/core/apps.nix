{pkgs, ...}: {
  imports = [
    ../overlays/vmware-modules.nix
  ];
  virtualisation = {
    docker.enable = true;
    vmware.host.enable = true;
  };
  environment.systemPackages = with pkgs; [
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
