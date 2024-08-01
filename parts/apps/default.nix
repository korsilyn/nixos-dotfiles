{
  perSystem = {pkgs, ...}: let
    callApps = path: import (path + /app.nix) {inherit pkgs;};
  in {
    apps = {
      prefetch-url-sha256 = callApps ./prefetch-url-sha256;
      check-restart = callApps ./check-restart;
      check-store-errors = callApps ./check-store-errors;
    };
  };
}
