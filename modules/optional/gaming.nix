{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    heroic
    mangohud
  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      steamtinkerlaunch
    ];
  };
}
