{ pkgs, config, nix-colors, ... }:
let
  inherit
    (nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
in
{

  qt = {
    enable = true;
    #platformTheme = "gnome";
    #style = "adwaita-dark";
  };

  gtk = {
    enable = true;
    theme = {
      name = "${config.colorScheme.slug}";
      #name = "Adwaita-dark";
      package = gtkThemeFromScheme { scheme = config.colorScheme; };
    };

    iconTheme = {
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons-Dark";
    };

    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };

  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
