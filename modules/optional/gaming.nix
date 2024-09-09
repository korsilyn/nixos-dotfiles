{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lutris
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
