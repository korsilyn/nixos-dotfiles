{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.modules.system.virtualization = {
    enable = mkEnableOption "virtualization";
    libvirt = {enable = mkEnableOption "libvirt";};
    docker = {enable = mkEnableOption "docker";};
    qemu = {enable = mkEnableOption "qemu";};
    waydroid = {enable = mkEnableOption "waydroid";};
    vmware = {enable = mkEnableOption "vmware.host";};
  };
}
