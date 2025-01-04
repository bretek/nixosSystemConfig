{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;

        ensure_installed = "all";
      };
      folding = true;
    };

    treesitter-refactor = {
      enable = false;
      highlightDefinitions = {
        enable = true;
        clearOnCursorMove = false;
      };
    };

    hmts.enable = true;
  };
}
