{
  config.modules.usr = {
    desktop = "sway";
    useHomeManager = true;

    programs = {
      launchers.fuzzel.enable = true;
      screenlock.swaylock.enable = true;
    };
  };
}
