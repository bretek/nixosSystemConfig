{ pkgs, lib, ... }:
{
  programs.nixvim = {
    extraPlugins =
      [
        (pkgs.vimUtils.buildVimPlugin {
          name = "roslyn-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "seblj";
            repo = "roslyn.nvim";
            rev = "31113dcd48d22b11850c832349b79bb7698d814a";
            sha256 = "sha256-iHNhMCw7VU/nyPOEJNM+Sr1w4rDqwBLe5oYM0zGDoRQ=";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          name = "rzls-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "tris203";
            repo = "rzls.nvim";
            rev = "b6696a894f7c8c1eb2ebdcc30f525501954bcbe8";
            sha256 = "sha256-tQtexoc3x2T1SUzp6K/nrf9x0N0srWnc0d6ueB74cFk=";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          name = "vim-razor";
          src = pkgs.fetchFromGitHub {
            owner = "jlcrochet";
            repo = "vim-razor";
            rev = "305dd1db88c657c0c02effbee1a88048479bb0c4";
            sha256 = "sha256-6obQ9nx3w/K8Jih/Xfub1iIYYl6f5GW9YEQmDZB38J8=";
          };
        })
      ];

    extraConfigLua = ''
      --local capabilities = vim.lsp.protocol.make_client_capabilities()

      local roslyn = require('roslyn');
      roslyn.setup({
          exe = 'Microsoft.CodeAnalysis.LanguageServer',
          args = {
              '--logLevel=Trace',
              '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
              --'--razorSourceGenerator=Microsoft.CodeAnalysis.LanguageServer',
              --'--razorDesignTimePath=rzls',
          },
          --filewatching = false,
          config = {
              handlers = require('rzls.roslyn_handlers'),
          },
      });
      require('rzls').setup({
          path='rzls'
      });
    '';
  };
}
