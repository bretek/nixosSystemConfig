{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        nixd = {
          enable = true;
          settings.formatting.command = [
            "nixpkgs-fmt"
          ];
        };

        nil_ls.enable = true;

        csharp_ls.enable = true;

        eslint = {
          enable = true;
          settings = {
            format = { enable = true; };
          };
        };
      };

      keymaps = {
        lspBuf = {
          K = "hover";
          "<leader>gr" = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
          "<leader>ca" = "code_action";
          "<leader>cr" = "rename";
        };
      };
    };

    lsp-format.enable = true;

    luasnip = {
      enable = true;
      fromVscode = [
        {
          lazyLoad = true;
          paths = "${pkgs.vimPlugins.friendly-snippets}";
        }
      ];
    };

    nvim-autopairs = {
      enable = true;
      settings = {
        disable_filetype = [ "TelescopePrompt" "vim" ];
      };
    };

    cmp = {
      enable = true;

      settings = {
        autoEnableSources = true;
        experimental = { ghost_text = true; };

        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };

        snippet = { expand = "luasnip"; };

        sources = [
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
          {
            name = "buffer"; # text within current buffer
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          {
            name = "path"; # file system paths
            keywordLength = 3;
          }
          {
            name = "luasnip"; # snippets
            keywordLength = 3;
          }
        ];

        window = {
          completion = { border = "none"; };
          documentation = { border = "solid"; };
        };

        mapping = {
          "<C-e>" = "cmp.mapping.select_next_item()";
          "<C-i>" = "cmp.mapping.select_prev_item()";
          "<CR>" = ''
            cmp.mapping(function(fallback)
            if cmp.visible() then
            if require("luasnip").expandable() then
            require("luasnip").expand()
            else
            cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true,})
            end
            else
            fallback()
            end
            end)
          '';
          "<S-CR>" = ''
            cmp.mapping(function(fallback)
            if cmp.visible() then
            if require("luasnip").expandable() then
            require("luasnip").expand()
            else
            cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true,})
            end
            else
            fallback()
            end
            end)
          '';
          "<Tab>" = ''
            cmp.mapping(function(fallback)
            if cmp.visible() then
            cmp.select_next_item()
            elseif require("luasnip").locally_jumpable(1) then
            require("luasnip").jump(1)
            else
            fallback()
            end
            end, {"i", "s"})
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
            if cmp.visible() then
            cmp.select_prev_item()
            elseif require("luasnip").locally_jumpable(-1) then
            require("luasnip").jump(-1)
            else
            fallback()
            end
            end, {"i", "s"})
          '';
        };
      };
    };

    cmp-nvim-lsp = { enable = true; }; # lsp
    cmp-buffer = { enable = true; };
    cmp-path = { enable = true; }; # file system paths
    cmp_luasnip = { enable = true; }; # snippets
    cmp-cmdline = { enable = false; }; # autocomplete for cmdline

    dap = {
      enable = true;
    };
  };
}
