{ pkgs, ... }:

{
  imports = [
    ../joseph.nix
    ./hardware-configuration.nix
  ];

  # Give group permissions for usb devs
  users.groups.plugdev = { };
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", MODE="0774", GROUP="plugdev"
    SUBSYSTEM=="hid", MODE="0774", GROUP="plugdev"
    SUBSYSTEM=="hidraw", MODE="0774", GROUP="plugdev"
    SUBSYSTEM=="video4linux", MODE="0774", GROUP="plugdev"
  '';

  # Enable USB redirection (optional)
  virtualisation.spiceUSBRedirection.enable = true;

  users.users.joseph = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
    ];
    shell = pkgs.zsh;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
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

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
  };

  powerManagement.enable = true;
  security.polkit.enable = true;
  services = {
    pulseaudio.enable = true;
    pipewire.enable = false;
    printing.enable = true;
    blueman.enable = true;
    thermald.enable = true;
    xserver.videoDrivers = [
      "displaylink"
    ];

    fprintd.enable = true;

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
          command = "sway --unsupported-gpu";
          user = "joseph";
        };
        initial_session = {
          command = "sway --unsupported-gpu";
          user = "joseph";
        };
      };
    };
  };

  security.pam.services.hyprlock = {
    text = ''
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth sufficient pam_fprintd.so
      auth requisite pam_deny.so
      auth required pam_permit.so
      auth        include     login
    '';
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
    wireshark
    fprintd

    qemu_kvm
  ];

  programs.dconf.enable = true;

  environment.variables = {
    WLR_EVDI_RENDER_DEVICE = "/dev/dri/card1";
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };
  nixpkgs.overlays = [
    (final: prev: {
      wlroots_0_18 = prev.wlroots_0_18.overrideAttrs (old: {
        # you may need to use 0_18
        patches = (old.patches or [ ]) ++ [
          (prev.fetchpatch {
            url = "https://gitlab.freedesktop.org/wlroots/wlroots/uploads/bd115aa120d20f2c99084951589abf9c/DisplayLink_v2.patch";
            hash = "sha256-vWQc2e8a5/YZaaHe+BxfAR/Ni8HOs2sPJ8Nt9pfxqiE=";
          })
        ];
      });
    })
  ];

  systemd.services.dlm.wantedBy = [ "multi-user.target" ];
  systemd.services.fprintd.wantedBy = [ "multi-user.target" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  system.stateVersion = "23.11";
}
