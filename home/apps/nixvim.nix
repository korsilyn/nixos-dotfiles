{...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        integrations = {
          cmp = true;
          treesitter = true;
        };
      };
    };
  };
}
