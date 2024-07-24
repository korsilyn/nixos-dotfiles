{ config, pkgs, ... }:
let
  leetmouse = config.boot.kernelPackages.callPackage ../../overlays/leetmouse-kernel.nix {};
in {
  boot.extraModulePackages = [ leetmouse ];
  boot.kernelModules = [ "leetmouse" ];
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEMS=="input|hid|usb", ATTRS{bInterfaceClass}=="03", ATTRS{bInterfaceSubClass}=="01", ATTRS{bInterfaceProtocol}=="02", \
    RUN+="${pkgs.runtimeShell} -c 'echo %k > /sys/bus/hid/drivers/hid-generic/unbind'", \
    RUN+="${pkgs.runtimeShell} -c 'echo %k > /sys/bus/usb/drivers/leetmouse/bind'" 
  '';
}
