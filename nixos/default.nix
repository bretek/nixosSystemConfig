{ pkgs, ... }:

{
  imports =
    [
      ../joseph.nix
      ./hardware-configuration.nix
    ];

  # Give group permissions for usb devs
  #users.groups.plugdev = { };
  #services.udev.extraRules = ''
  #  SUBSYSTEM=="usb", MODE="0774", GROUP="plugdev"
  #  SUBSYSTEM=="hid", MODE="0774", GROUP="plugdev"
  #  SUBSYSTEM=="hidraw", MODE="0774", GROUP="plugdev"
  #  SUBSYSTEM=="video4linux", MODE="0774", GROUP="plugdev"
  #'';

  users.users.joseph = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
  ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.inter
      pkgs.fira
    ];
    fontconfig.defaultFonts = {
      serif = [ "Inter" ];
      sansSerif = [ "Inter" ];
      monospace = [ "FiraMono" ];
    };
  };

  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  security.polkit.enable = true;
  services = {
    pipewire.enable = false;
    printing.enable = true;
    blueman.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "sway";
          user = "joseph";
        };
        initial_session = {
          command = "sway";
          user = "joseph";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    wget
    unzip
    zip
    gzip
    fd
    ripgrep
    usbutils
    tree
    neofetch
    gnupg
    feh
  ];

  programs.dconf.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  system.stateVersion = "23.11";
}

