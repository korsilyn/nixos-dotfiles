{pkgs, inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.commom-pc-laptop

    ./hardware-configuration.nix

    ../../modules/common/

    ../../modules/optional/docker.nix
    ../../modules/optional/peripherals.nix
    ../../modules/optional/quietboot.nix
    ../../modules/optional/tlp.nix
    ../../modules/optional/vmware.nix
    ../../modules/optional/wireless.nix
  ];

  networking.useDHCP = true;

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
