{
  # despite being under logind, this has nothing to do with login
  # it's about power management
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    extraConfig = ''
      HandlePowerKey=suspend
    '';
  };
}
