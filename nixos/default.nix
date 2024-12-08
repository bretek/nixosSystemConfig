{ ... }:

{
  imports =
    [
      ../modules/os.nix
      ../modules/system.nix
      ../modules/development.nix

      ../modules/dj.nix

      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  system.stateVersion = "23.11";
}

