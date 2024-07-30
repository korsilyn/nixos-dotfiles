{
  xdg.configFile."fastfetch".source  = ./fastfetch;
  imports = [
    ./git

    ./bat.nix
    ./editorconfig.nix
    ./eza.nix
    ./fzf.nix
    ./man.nix
    ./nix-direnv.nix
    ./nix-index.nix
    ./ripgrep.nix
    ./ssh.nix
  ];
}
