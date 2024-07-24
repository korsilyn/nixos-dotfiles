{ config, pkgs, ... }:
let
  leetmouse = config.boot.kernelPackages.callPackage ../../overlays/leetmouse-kernel.nix {};
in {
  boot.extraModulePackages = [ leetmouse ];
  boot.kernelModules = [ "leetmouse" ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="input", KERNEL=="mouse[0-9]", \
    RUN+="${pkgs.runtimeShell} -c 'echo $kernel > /sys/bus/hid/drivers/hid-generic/unbind'", \
    RUN+="${pkgs.runtimeShell} -c 'echo $kernel > /sys/bus/usb/drivers/leetmouse/bind'" 
  '';
}
