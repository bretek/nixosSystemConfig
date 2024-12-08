{pkgs, ...}:
{
  programs.nixvim = {
      plugins.dap.enable = true;
      extraPlugins = with pkgs.vimExtraPlugins; [
      mason-nvim
      mason-lspconfig-nvim
    ];
  };
}
