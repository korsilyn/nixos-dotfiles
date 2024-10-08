{
  lib,
  pkgs,
  ...
}: {
  hardware = {
    pulseaudio.enable = false;
    pulseaudio.support32Bit = true;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
  environment.systemPackages = with pkgs; [helvum];
}
