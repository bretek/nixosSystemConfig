{ pkgs, nix-colors, ... }:
{
  imports = [
    ./system
    ./terminal
    ./nvim
  ];

  colorScheme = nix-colors.colorSchemes.material-darker;

  home = {
    username = "joseph";
    homeDirectory = "/home/joseph";

    stateVersion = "23.11";

    packages = with pkgs; [
      mixxx
      spotdl
      gnome-sudoku
      inkscape
    ];
  };


  #programs.home-manager.enable = true;
  #programs.java.enable = true;
}

