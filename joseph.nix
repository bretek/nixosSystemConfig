{ pkgs, ... }: {
  imports = [
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
    nixfmt-rfc-style

    wl-clipboard

    firefox

    rzls
    roslyn-ls
    ccls
  ];

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.zsh.enable = true;
}

