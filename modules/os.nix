{ pkgs, ... }:
{
  nixpkgs.overlays = [
    #(import ../overlays/roslyn-lsOverlay.nix)
    (import ../overlays/keydOverlay.nix)
  ];

  nixpkgs.config.android_sdk.accept_license = true;
  environment.systemPackages = with pkgs; [
    pavucontrol
    kanshi
    brightnessctl
    playerctl
    fzf
    nix-search-cli
    swayosd
    keyd

    git
    curl
    wget
    unzip
    zip
    gzip
    fd
    ripgrep
    usbutils
    tree
    lazygit

    devenv


    inkscape

    #displaylink

    #omnisharp-roslyn
    #roslyn
    roslyn-ls
    #netcoredbg
    #dotnet-sdk_8
    #dotnet-runtime_8
    dotnetCorePackages.sdk_8_0
    (pkgs.callPackage ../modules/rzls/rzls.nix { })
    #(pkgs.callPackage ../modules/RazorCompiler/RazorCompiler.nix { })
    #(pkgs.callPackage ../modules/roslyn/roslyn.nix { })

    #nodejs
    #watchman
    #jdk
    #androidsdk_extras
    #android-tools
    #android-studio-full
    #gradle
    #nodePackages.expo-cli
    #(android-studio.withSdk (androidenv.composeAndroidPackages {
    #includeNDK = true;
    #platformVersions = [ "34" ];
    #includeSystemImages = false;
    #}).androidsdk)

    wl-clipboard


    #roslyn-ls


    jack2

    #mako
    #cliphist
  ];

  #environment.sessionVariables = {
  #  DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
  #};

  nix.settings.trusted-users = [ "root" "@wheel" ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      overpass
      inter
      fira
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Inter" ];
        sansSerif = [ "Inter" ];
        #monospace = ["Inter"];
        #serif = ["FiraCode"];
        #sansSerif = ["FiraSans"];
        monospace = [ "FiraMono" ];
      };
    };
  };

  #xdg = {
  #  portal = {
  #    enable = true;
  #    extraPortals = with pkgs; [
  #      xdg-desktop-portal-wlr
  #      xdg-desktop-portal-gtk
  #    ];
  #  };
  #};

  #catppuccin.enable = true;
  #catppuccin.flavor = "mocha";

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            #tab = "overloadt2(shift, tab, 150)";
            tab = "layer(shift)";
            enter = "space";
            #shift = "layer(modLayer)";

            space = "layer(modLayer)";
            capslock = "layer(symbolLayer)";

            a = "lettermod(alt, a, 160, 180)";
            s = "lettermod(meta, s, 160, 180)";
            d = "lettermod(control, d, 160, 180)";
            f = "lettermod(shift, f, 90, 160)";
            j = "lettermod(shift, j, 90, 160)";
            k = "lettermod(control, k, 160, 180)";
            l = "lettermod(meta, l, 160, 180)";
            ";" = "lettermod(alt,;, 160, 180)";
          };

          symbolLayer = {
            a = "!";
            s = "=";
            q = "[";
            w = "]";
            e = "{";
            r = "}";
            d = "(";
            f = ")";
            t = "^";
            g = "/";
            b = "`";
            y = "|";
            h = "\\";
            n = "~";
            j = "\"";
            u = "'";
            k = "_";
            i = "$";
            o = "#";
            z = "@";
            v = "%";
            m = "&";
          };

          modLayer = {
            v = "0";
            z = "1";
            x = "2";
            c = "3";
            s = "4";
            d = "5";
            f = "6";
            w = "7";
            e = "8";
            r = "9";

            q = "+";
            a = "-";
            t = "*";
            b = "=";

            n = "esc";
            h = "enter";
            y = "tab";

            j = "left";
            k = "down";
            l = "up";
            semicolon = "right";

            u = "home";
            i = "backspace";
            o = "delete";
            p = "end";
            #a = "~";
            #s = "[";
            #x = "]";
            #d = "{";
            #c = "}";
            #f = "(";
            #v = ")";

            #j = "left";
            #k = "down";
            #l = "up";
            #semicolon = "right";

            #u = "home";
            #i = "backspace";
            #o = "delete";
            #p = "end";
          };

          #shift = {
          #  shift = "toggle(capslock)";
          #};

          #rightshift = {
          #  m = "1";
          #  "," = "2";
          #  "." = "3";
          #  j = "4";
          #  k = "5";
          #  l = "6";
          #  u = "7";
          #  i = "8";
          #  o = "9";

          #  w = "!";
          #  e = "@";
          #  r = "#";
          #  s = "$";
          #  d = "%";
          #  f = "^";
          #  x = "&";
          #  c = "*";
          #};
        };
      };
    };
  };

  services.greetd = {
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

  #services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  #services.gnome.gnome-keyring.enable = true;

  #    programs.sway = {
  #      enable = true;
  #      wrapperFeatures.gtk = true;
  #    };
  #    programs.waybar.enable = true;
  #programs.regreet.enable = true;

  services.blueman.enable = true;
  programs.dconf.enable = true;

  #    programs.zsh.enable = true;


}

