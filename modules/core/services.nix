{
  pkgs,
  inputs,
  ...
}: {
  systemd.services.seatd = {
    enable = true;
    description = "Seat management daemon";
    script = "${pkgs.seatd}/bin/seatd -g wheel";
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "1";
    };
    wantedBy = ["multi-user.target"];
  };

  services = {
    logind = {
      lidSwitch = "hibernate";
      lidSwitchExternalPower = "suspend";
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
      ];
    };

    udisks2.enable = true;
    fstrim.enable = true;
  };
}
