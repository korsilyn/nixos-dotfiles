{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
in {
  programs.firejail = let
    profiles = "${pkgs.firejail}/etc/firejail";
  in {
    enable = true;
    wrappedBinaries = with pkgs; {
      mpv = {
        executable = getExe mpv;
        profile = "${profiles}/mpv.profile";
      };

      imv = {
        executable = pkgs.imv + /bin/imv;
        profile = "${profiles}/imv.profile";
      };

      zathura = {
        executable = getExe zathura;
        profile = "${profiles}/zathura.profile";
      };
    };
  };
}
