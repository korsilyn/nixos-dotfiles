{
  modules.usrEnv = {
    desktop = "sway";
    useHomeManager = true;

    programs = {
      media.mpv.enable = true;

      launchers = {
        fuzzel.enable = true;
      };

      screenlock.swaylock.enable = true;
    };
  };
}
