{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment = {
    sessionVariables.FLAKE = "/home/korsilyn/repos/nixos-dotfiles";
    etc."nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
    systemPackages = 
      (with pkgs; [
        git
        deadnix
        alejandra
        statix
        nix-output-monitor
      ]);
    defaultPackages = [];
  };

  nixpkgs.config.allowUnfree = true;

  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  programs.nh = {
    enable = true;
    flake = "/home/korsilyn/repos/nixos-dotfiles";
  };

  nix = {
    # GC is bad for SSDs
    gc.automatic = lib.mkDefault false;

    # Nix fork
    package = pkgs.lix;

    # More responsive
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";

    # Avoid downloading and evaling every time
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    # Consistent legacy nix
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Free up to 10GiB wherever there is less than 2GiB left
    extraOptions = ''
      experimental-features = nix-command flakes recursive-nix
      keep-outputs = true
      warn-dirty = false
      keep-derivations = true
      min-free = ${toString (10 * 1024 * 1024 * 1024)}
      max-free = ${toString (2 * 1024 * 1024 * 1024)}
    '';

    settings = {
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      # Binary cache
      builders-use-substitutes = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      ];
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
      sandbox = true;
      max-jobs = "auto";
      keep-going = true;
      log-lines = 20;
      extra-experimental-features = ["flakes" "nix-command" "recursive-nix" "ca-derivations"];
    };
  };
  system.autoUpgrade.enable = false;
  system.stateVersion = "24.05";
}
