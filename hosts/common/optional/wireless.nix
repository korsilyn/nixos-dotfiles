{
  config,
  ...
}: {
  # Wireless secrets stored through sops
  sops.secrets.wireless = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  networking.wireless = {
    enable = true;
    # Declarative
    environmentFile = config.sops.secrets.wireless.path;
    networks = {
      "Sander5G" = {
        psk = "@SANDER@";
      };
      "Yustas Staff" = {
        authProtocols = ["WPA-EAP"];
        auth = ''
          eap=WEAP
          identity="egladkov"
          password="@YUSTAS_STAFF@"
          phase2="auth=MSCHAPV2"
        '';
      };
    };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };
    extraConfig = ''
      update_config=1
    '';
  };

  # Ensure group exists
  users.groups.network = {};

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
