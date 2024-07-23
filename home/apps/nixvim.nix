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
    globals.mapleader = " ";
    clipboard = {
      providers.wl-copy.enable = true;
      register = "unnamedplus";
    };
    viAlias = true;
    vimAlias = true;
    opts = {
      breakindent = true;
      confirm = true;
      copyindent = true;
      cursorline = true;
      expandtab = true;
      # Fold
      foldcolumn = "1";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      ignorecase = true;
      infercase = true;
      laststatus = 3;
      linebreak = true;
      mouse = "a";
      number = true;
      preserveindent = true;
      relativenumber = true;
      shiftwidth = 2;
      showtabline = 2;
      signcolumn = "yes";
      smartcase = true;
      softtabstop = 2;
      tabstop = 2;
      termguicolors = true;
      undofile = true;
      wrap = false;
      writebackup = false;
    };
  };
}
