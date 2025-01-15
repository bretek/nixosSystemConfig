{ ... }:
{
  programs.direnv = {
    enable = true;
    config = { hide_env_diff = true; };
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
      bind c new-window -c "#{pane_current_path}"
      set -g status-style "bg=brightblack"
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "history"
        "branch"
        "fzf"
      ];
    };
    initExtra = ''
      	bindkey "^[c" fzf-cd-widget
    '';
  };
}
