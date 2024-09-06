{pkgs, inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.commom-pc-laptop

    ./hardware-configuration.nix

    ../common/global
    ../common/users/korsilyn

    ../common/optional/docker.nix
    ../common/optional/peripherals.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/tlp.nix
    ../common/optional/vmware.nix
    ../common/optional/wireless.nix
  ];

  networking = {
    hostName = "alhena";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_latest;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "i686-linux"
    ];
  };

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
    dconf.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  hardware.graphics.enable = true;

  system.stateVersion = "24.05";
}
