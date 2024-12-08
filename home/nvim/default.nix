{ ... }:
{
  imports = [
    ./plugins
    ./keymappings.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    opts = {
      updatetime = 50;

      relativenumber = true;
      number = true;
      scrolloff = 8;
      signcolumn = "yes";
      colorcolumn = "80";
      termguicolors = true;
      wrap = false;

      hlsearch = true;
      incsearch = true;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;

      undofile = true;

      foldlevel = 99;
    };
  };
}
