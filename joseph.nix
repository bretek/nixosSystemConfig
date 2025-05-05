{ pkgs, ... }:
{
  imports = [
    #./modules/keyd.nix
  ];

  environment.systemPackages = with pkgs; [
    sway
    pavucontrol
    brightnessctl
    playerctl
    fzf
    nix-search-cli
    swayosd

    git
    lazygit
    devenv
    nixfmt-rfc-style

    qemu
    quickemu

    wireshark

    gdb
    netcoredbg

    ghidra-bin

    wl-clipboard
    cryptsetup
    udisks2

    firefox-wayland
    glow
    bitwig-studio
    reaper
    libreoffice
    blender
    imagemagickBig
    gimp
    zoom-us
    wireguard-tools

    rzls
    roslyn-ls
    ccls
    python313Packages.jedi
  ];

  services.udisks2.enable = true;

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.zsh.enable = true;
}
