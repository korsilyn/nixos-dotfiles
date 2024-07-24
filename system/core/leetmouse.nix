{ config, pkgs, ... }:
let
  leetmouse = config.boot.kernelPackages.callPackage ../../overlays/leetmouse-kernel.nix {};
in {
  boot.extraModulePackages = [ leetmouse ];
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEMS=="usb|input|hid", ENV{ID_INPUT_MOUSE}=="1", \
    RUN+="${pkgs.runtimeShell} -c 'echo $kernel > /sys/bus/hid/drivers/hid-generic/unbind'", \
    RUN+="${pkgs.runtimeShell} -c 'echo $kernel > /sys/bus/usb/drivers/leetmouse/bind'" 
  '';
}
