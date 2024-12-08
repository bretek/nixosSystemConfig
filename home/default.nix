{ pkgs, nix-colors, ... }:
{
  imports = [
    ./fonts
    ./sway
    ./zsh
    ./gtk
    ./nvim
    ./tmux
    nix-colors.homeManagerModules.default
  ];

  colorScheme = nix-colors.colorSchemes.material-darker;

  home = {
    username = "joseph";
    homeDirectory = "/home/joseph";

    stateVersion = "23.11";

    packages = [
      pkgs.mixxx
      pkgs.gnome-sudoku
      pkgs.gnome-2048
      pkgs.gnome-frog
    ];

  };

  programs.home-manager.enable = true;
  programs.java.enable = true;
}

