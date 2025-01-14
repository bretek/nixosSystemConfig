{ config, lib, ... }: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps =
      let
        normal =
          lib.mapAttrsToList
            (key: action: {
              mode = "n";
              inherit action key;
            })
            {
              # Keep active line centered
              "<C-d>" = "<C-d>zz";
              "<C-u>" = "<C-u>zz";
              "n" = "nzzzv";
              "N" = "Nzzzv";

              # Paste last yanked instead of delete buffer
              "<leader>p" = "\"0p";
              "<leader>P" = "\"0P";

              # Clipboard
              "<leader>sy" = "\"+y";
              "<leader>sp" = "\"+p";
              "<leader>sP" = "\"+P";
            };
      in
      config.lib.nixvim.keymaps.mkKeymaps
        { options.silent = true; }
        normal;
  };
}
