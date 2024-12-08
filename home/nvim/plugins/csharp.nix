{ pkgs, lib, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.omnisharp-extended-lsp-nvim
    ]
    ++ [
      # (pkgs.vimUtils.buildVimPlugin {
      #     name = "vim-razor";
      #     src = pkgs.fetchFromGitHub {
      #     owner = "jlcrochet";
      #     repo = "vim-razor";
      #     rev = "305dd1db88c657c0c02effbee1a88048479bb0c4";
      #     sha256 = "sha256-6obQ9nx3w/K8Jih/Xfub1iIYYl6f5GW9YEQmDZB38J8=";
      # };
      # })
      #name = "vim-csharp";
      #src = pkgs.fetchFromGitHub {
      #    owner = "OrangeT";
      #    repo = "vim-csharp";
      #    rev = "b5982fc69bba7d507638a308d6875b031054280d";
      #    sha256 = "sha256-ndFo3mG0UoMK3KyPoHj1L0+6p5aHG5hnJsuMtrEfTps=";
      #};
      (pkgs.vimUtils.buildVimPlugin {
        name = "roslyn-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "jmederosalvarado";
          repo = "roslyn.nvim";
          rev = "3e360ea5a15f3cf7ddef02ff003ef24244cdff3a";
          sha256 = "sha256-0mvlEE3/qGkv2dLzthWwGgdVTmp2Y/WJLv9ihcPumBo=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "rzls-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "tris203";
          repo = "rzls.nvim";
          rev = "cbf3714d3ab7d5f0378e44d1bb0a8cae392cd958";
          sha256 = "sha256-HYXgmsu0eJ+7hklJE41rkVYVCMLOg55Hxz7T7kTztqE=";
        };
      })
    ];

    extraConfigLua = ''
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      --capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      require('rzls').setup({
          capabilities = capabilities,
          path = "/home/joseph/Programming/razor/artifacts/bin/rzls/Release/net8.0/"});

      require('roslyn').setup();
      --require('vim-razor').setup();
      --require('csharp').setup()
      --require('vim-csharp').setup()
    '';
  };
}
