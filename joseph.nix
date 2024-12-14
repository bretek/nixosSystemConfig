{ pkgs, ... }:
{
  imports =
    [
      ./modules/keyd.nix
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

    dotnetCorePackages.sdk_8_0

    firefox
  ];

  programs.zsh.enable = true;
}

