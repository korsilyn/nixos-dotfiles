{ config, pkgs, ... }:
let
  leetmouse = config.boot.kernelPackages.callPackage ../../overlays/leetmouse-kernel.nix {};
in {
  boot.extraModulePackages = [ leetmouse ];
  services.udev.extraRules = ''
    ACTION=="bind", SUBSYSTEMS=="usb|input|hid", ID_INPUT_MOUSE=="1", \
    RUN+="${pkgs.runtimeShell} -c 'echo $kernel > /sys/bus/hid/drivers/hid-generic/unbind'", \
    RUN+="${pkgs.runtimeShell} -c 'echo $kernel > /sys/bus/hid/drivers/leetmouse/bind'" 
  '';
}
