{ pkgs, config, ... }:
{

  imports = [
    ./treesitter.nix
    ./telescope.nix
    ./lsp.nix
    ./ts-autotag.nix
  ];

  programs.nixvim = {
    colorschemes.base16.enable = true;
    colorschemes.base16.colorscheme =
      {
        base00 = "#${config.colorScheme.palette.base00}";
        base01 = "#${config.colorScheme.palette.base01}";
        base02 = "#${config.colorScheme.palette.base02}";
        base03 = "#${config.colorScheme.palette.base03}";
        base04 = "#${config.colorScheme.palette.base04}";
        base05 = "#${config.colorScheme.palette.base05}";
        base06 = "#${config.colorScheme.palette.base06}";
        base07 = "#${config.colorScheme.palette.base07}";
        base08 = "#${config.colorScheme.palette.base08}";
        base09 = "#${config.colorScheme.palette.base09}";
        base0A = "#${config.colorScheme.palette.base0A}";
        base0B = "#${config.colorScheme.palette.base0B}";
        base0C = "#${config.colorScheme.palette.base0C}";
        base0D = "#${config.colorScheme.palette.base0D}";
        base0E = "#${config.colorScheme.palette.base0E}";
        base0F = "#${config.colorScheme.palette.base0F}";
      };

    plugins.web-devicons.enable = true;

    extraPlugins = [
      pkgs.vimPlugins.rzls-nvim
    ];

    extraConfigLua = ''
        local __lspCapabilities = function()
            capabilities = vim.lsp.protocol.make_client_capabilities()

            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            return capabilities
        end

        require('rzls').setup({
            path = '${pkgs.rzls}/bin/rzls',
            on_attach = on_attach,
            capabilities = __lspCapabilities(),
        });

        require('roslyn').setup {
        exe = '${pkgs.roslyn-ls}/bin/Microsoft.CodeAnalysis.LanguageServer',

        args = {
          '--logLevel=Information',
          '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
          '--razorSourceGenerator=${pkgs.rzls}/lib/rzls/Microsoft.CodeAnalysis.Razor.Compiler.dll',
          '--razorDesignTimePath=${pkgs.rzls}/lib/rzls/Targets/Microsoft.NET.Sdk.Razor.DesignTime.targets',
        },

        config = {
          on_attach = on_attach,
          capabilities = __lspCapabilities(),
          handlers = require('rzls.roslyn_handlers'),
          settings = {
            ['csharp|inlay_hints'] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,

              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ['csharp|code_lens'] = {
              dotnet_enable_references_code_lens = true,
            },
          },
        },
      }
    '';
  };
}
