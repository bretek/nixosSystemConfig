{ pkgs, ... }:

{
  imports = [ ../joseph.nix ./hardware-configuration.nix ];

  # Give group permissions for usb devs
  users.groups.plugdev = { };
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", MODE="0774", GROUP="plugdev"
    SUBSYSTEM=="hid", MODE="0774", GROUP="plugdev"
    SUBSYSTEM=="hidraw", MODE="0774", GROUP="plugdev"
    SUBSYSTEM=="video4linux", MODE="0774", GROUP="plugdev"
  '';

  users.users.joseph = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
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

  nixpkgs.config.permittedInsecurePackages = [ "dotnet-sdk-6.0.428" ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  fonts = {
    enableDefaultPackages = true;
    packages = [ pkgs.inter pkgs.fira ];
    fontconfig.defaultFonts = {
      serif = [ "Inter" ];
      sansSerif = [ "Inter" ];
      monospace = [ "FiraMono" ];
    };
  };

  powerManagement.enable = true;
  hardware.bluetooth.enable = true;
  security.polkit.enable = true;
  services = {
    pulseaudio.enable = true;
    pipewire.enable = false;
    printing.enable = true;
    blueman.enable = true;
    thermald.enable = true;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
    };

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

