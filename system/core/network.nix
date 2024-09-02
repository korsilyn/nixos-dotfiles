{
  pkgs,
  lib,
  config,
  ...
}: {
  networking = {
    nameservers = ["1.1.1.1" "1.0.0.1"];
    networkmanager = {
      enable = true;
      unmanaged = ["docker0"];
      wifi = {
        macAddress = "random";
        powersave = true;
      };
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
