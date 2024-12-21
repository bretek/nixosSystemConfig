{ pkgs, ... }:
{
  imports =
    [
      #./modules/keyd.nix
    ];

  environment.systemPackages = with pkgs; [
    pavucontrol
    kanshi
    brightnessctl
    playerctl
    fzf
    nix-search-cli
    swayosd

    git
    lazygit
    devenv

    wl-clipboard

    firefox
  ];

  programs.zsh.enable = true;
}

