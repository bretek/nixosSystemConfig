{ pkgs
, ...
}:
let
  username = "joseph";
in
{
  users.groups.plugdev = { };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", MODE="0774", GROUP="plugdev"
    SUBSYSTEM=="hid", MODE="0774", GROUP="plugdev"
    SUBSYSTEM=="hidraw", MODE="0774", GROUP="plugdev"
    SUBSYSTEM=="video4linux", MODE="0774", GROUP="plugdev"
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joseph = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
    shell = pkgs.zsh;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Hardware
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;
  services.pipewire.enable = false;

  hardware.bluetooth.enable = true;

  #hardware.graphics.enable = true;
  #};

  security.polkit.enable = true;


  # Services
  services.printing.enable = true;

  programs.zsh.enable = true;

  # Apps
  environment.systemPackages = with pkgs; [
    firefox
    vim
    #wget
    #curl
    #git
    #sysstat
    #lm_sensors # for `sensors` command
    neofetch
    #xfce.thunar # xfce4's file manager
    #nnn # terminal file manager
  ];
}
