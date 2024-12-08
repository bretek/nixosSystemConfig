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
      enable = true;
      highlightDefinitions = {
        enable = true;
        # Set to false if you have an `updatetime` of ~100.
        clearOnCursorMove = false;
      };
    };

    hmts.enable = true;
  };
}
