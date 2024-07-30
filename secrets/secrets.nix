let
  keys = import ../parts/keys.nix;
  inherit (keys) servers workstations;
  inherit (keys) mkGlobal;
in { }
