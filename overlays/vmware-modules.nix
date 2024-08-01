{ config, pkgs, lib, ...}: {
  nixpkgs.overlays = [
    (self: super: {
      linuxPackages_latest = super.linuxPackages_latest.extend (lpself: lpsuper: {
        vmware = super.linuxPackages_latest.vmware.overrideAttrs (oldAttrs: {
          src = pkgs.fetchFromGitHub {
            owner = "nan0desu";
            repo = "vmware-host-modules";
            rev = "d9f51ee";
            hash = "sha256-63ZYa3X3fVpJQuHoBuqP5fs64COAgjJ9iG9LNkXPXfw=";
          };
        });
      });
    })
  ];
}
