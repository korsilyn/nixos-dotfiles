{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        globalstatus = true;
        extensions = [
          "fzf"
          "neo-tree"
        ];
        disabled_filetypes = {
          statusline = ["startup" "alpha"];
        };
        theme = "catppuccin";
        sections = {
          lualine_a = [
            {
              name = "mode";
              icon = " ";
            }
          ];
          lualine_b = [
            {
              name = "branch";
              icon = "";
            }
            {
              name = "diff";
              extraConfig = {
                symbols = {
                  added = " ";
                  modified = " ";
                  removed = " ";
                };
              };
            }
          ];
          lualine_c = [
            {
              name = "diagnostics";
              extraConfig = {
                sources = ["nvim_lsp"];
                symbols = {
                  error = " ";
                  warn = " ";
                  info = " ";
                  hint = "󰝶 ";
                };
              };
            }
            {
              name = "navic";
            }
          ];
          lualine_x = [
            {
              name = "filetype";
              extraConfig = {
                icon_only = true;
                separator = "";
                padding = {
                  left = 1;
                  right = 0;
                };
              };
            }
            {
              name = "filename";
              extraConfig = {
                path = 1;
              };
            }
          ];
          lualine_y = [
            {
              name = "progress";
            }
          ];
          lualine_z = [
            {
              name = "location";
            }
          ];
        };
      };
    };
  };
}
