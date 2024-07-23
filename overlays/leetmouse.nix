{ config, ... }:
let
  leetmouse = config.boot.kernelPackages.callPackage ./leetmouse-kernel.nix {};
in {
  boot.extraModulePackages = [ leetmouse ];
  services.udev.extraRules = ''
    ACTION=="bind", SUBSYSTEMS=="usb|input|hid", ID_INPUT_MOUSE=="1", \
    RUN+="/bin/bash -c 'echo $kernel > /sys/bus/hid/drivers/hid-generic/unbind'", \
    RUN+="/bin/bash -c 'echo $kernel > /sys/bus/hid/drivers/leetmouse/bind'" 
  '';
}
