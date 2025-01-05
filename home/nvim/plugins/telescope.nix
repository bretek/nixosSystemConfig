{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        # Find files using Telescope command-line sugar.
        "<leader>fp" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fh" = "help_tags";
        "<leader>fd" = "diagnostics";

        # FZF like bindings
        "<C-p>" = "git_files";
        "<leader>p" = "oldfiles";
      };

      settings.defaults = {
        set_env.COLORTERM = "truecolor";
        file_ignore_patterns = [
          "%__virtual.cs$"
        ];
      };
    };
  };
}
