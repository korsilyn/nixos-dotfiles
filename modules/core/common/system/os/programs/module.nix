{
  imports = [
    ./direnv.nix
    ./git.nix
    ./zsh.nix
  ];

  programs = {
    # less pager
    less.enable = true;

    # run commands without installing the programs
    comma.enable = true;
  };
}
