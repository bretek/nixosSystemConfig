{ lib, config, ... }:
{
  imports = [
    ./fonts.nix
    ./waybar
    ./wlogout
    ./gtkQt.nix
    ./kanshi.nix
    ./kitty.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  programs.wofi.enable = true;

  wayland.windowManager.sway = {
    enable = true;

    wrapperFeatures.gtk = true;

    swaynag.enable = true;

    extraSessionCommands = ''
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
    '';

    extraConfigEarly = ''
      	workspace 1
    '';
    config = {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty";
      defaultWorkspace = "workspace 1";
      startup = [
        # Launch Firefox on start
        { command = "firefox"; }
        { command = "hyprlock"; }
        {
          command = "pkill kanshi; kanshi";
          always = true;
        }
      ];

      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+q" = "workspace number 1";
          "${modifier}+w" = "workspace number 2";
          "${modifier}+f" = "workspace number 3";

          "${modifier}+Backspace" = "exec pidof wlogout || wlogout -n -b 2";
          "${modifier}+l" = "exec hyprlock";

          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          "XF86MonBrightnessUp" = "exec brightnessctl s +5%";
          "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";

          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPause" = "exec playerctl play-pause";
        };


      input = {
        "*" = {
          xkb_layout = "us";
          xkb_variant = "colemak";
          repeat_delay = "250";
          repeat_rate = "30";
        };
      };

      window = {
        border = 1;
        hideEdgeBorders = "smart";
        titlebar = false;
      };

      bars = [
        {
          command = "waybar";
        }
      ];

      output = {
        eDP-1 = {
          mode = "2160x1440";
          scale = "1.3";
        };

        "*" = {
          bg = "${./black_sand.jpg} fill";
        };
      };

      gaps = {
        inner = 10;
        outer = 10;
        top = 0;
        smartBorders = "on";
        smartGaps = true;
      };

      menu = "wofi --show=drun";

      floating = {
        border = 4;
      };

      colors = {
        background = "#${config.colorScheme.palette.base00}";
        focused = {
          background = "#${config.colorScheme.palette.base00}";
          border = "#${config.colorScheme.palette.base05}";
          childBorder = "#${config.colorScheme.palette.base05}";
          indicator = "#${config.colorScheme.palette.base05}";
          text = "#${config.colorScheme.palette.base05}";
        };
        focusedInactive = {
          background = "#${config.colorScheme.palette.base01}";
          border = "#${config.colorScheme.palette.base04}";
          childBorder = "#${config.colorScheme.palette.base04}";
          indicator = "#${config.colorScheme.palette.base04}";
          text = "#${config.colorScheme.palette.base05}";
        };
        unfocused = {
          background = "#${config.colorScheme.palette.base01}";
          border = "#${config.colorScheme.palette.base04}";
          childBorder = "#${config.colorScheme.palette.base04}";
          indicator = "#${config.colorScheme.palette.base04}";
          text = "#${config.colorScheme.palette.base05}";
        };
        urgent = {
          background = "#${config.colorScheme.palette.base08}";
          border = "#${config.colorScheme.palette.base08}";
          childBorder = "#${config.colorScheme.palette.base08}";
          indicator = "#${config.colorScheme.palette.base08}";
          text = "#${config.colorScheme.palette.base00}";
        };
        placeholder = {
          background = "#${config.colorScheme.palette.base00}";
          border = "#${config.colorScheme.palette.base00}";
          childBorder = "#${config.colorScheme.palette.base00}";
          indicator = "#${config.colorScheme.palette.base00}";
          text = "#${config.colorScheme.palette.base05}";
        };
      };
    };
  };
}
