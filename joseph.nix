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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.zsh.enable = true;
}

