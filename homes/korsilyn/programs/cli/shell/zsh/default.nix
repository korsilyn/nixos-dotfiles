{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    programs.zsh = {
      enable = true;
    };
  };
  home.file.".zshrc".source = ./zsh/zshrc;
  home.file.".p10k.zsh".source = ./zsh/p10k.zsh;
  home.file.".zprofile".source = ./zsh/zprofile;
}
