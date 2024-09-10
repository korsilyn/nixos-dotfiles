{
  programs.nixvim = {
    plugins.navic = {
      enable = true;
      settings = {
        separator = "  ";
        highlight = true;
        depth_limit = 5;
        lsp.auto_attach = true;
        icons = {
          Array = "󱃵  ";
          Boolean = "  ";
          Class = "  ";
          Constant = "  ";
          Constructor = "  ";
          Enum = " ";
          EnumMember = " ";
          Event = " ";
          Field = "󰽏 ";
          File = " ";
          Function = "󰡱 ";
          Interface = " ";
          Key = "  ";
          Method = " ";
          Module = "󰕳 ";
          Namespace = " ";
          Null = "󰟢 ";
          Number = " ";
          Object = "  ";
          Operator = " ";
          Package = "󰏖 ";
          String = " ";
          Struct = " ";
          TypeParameter = " ";
          Variable = " ";
        };
      };
    };
  };
}
