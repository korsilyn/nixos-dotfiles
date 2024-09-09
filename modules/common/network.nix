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
    wireless = {
      enable = true;
      allowAuxiliaryImperativeNetworks = true;
      userControlled = {
        enable = true;
        group = "network";
      };
      extraConfig = ''
        update_config=1
      '';
    };
  };

  # Ensure group exists
  users.groups.network = {};

  systemd.services = {
    wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
    NetworkManager-wait-online.enable = false;
  };
}
