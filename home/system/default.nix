{
  pkgs,
  lib,
  config,
  ...
}:
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

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${./black_sand.jpg}"
      ];
      wallpaper = [
        ",${./black_sand.jpg}"
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      "$terminal" = "kitty";
      "$mainMod" = "SUPER";

      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        repeat_delay = "250";
        repeat_rate = "30";
      };

      exec-once = [
        "firefox"
        "waybar"
      ];

      general = {
        layout = "dwindle";
        resize_on_border = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      workspace = [
        "w[t1], gapsout:0"
        "w[t1], border:0"
      ];

      bind = [
        "SUPER, RETURN, exec, kitty"
        "SUPER, D, exec, wofi --show=drun"

        "SUPER_SHIFT, Q, killactive"
        "SUPER, LEFT, movefocus, l"
        "SUPER, RIGHT, movefocus, r"
        "SUPER, UP, movefocus, u"
        "SUPER, DOWN, movefocus, d"

        "SUPER_SHIFT, LEFT, movewindow, l"
        "SUPER_SHIFT, UP, movewindow, u"
        "SUPER_SHIFT, DOWN, movewindow, d"
        "SUPER_SHIFT, RIGHT, movewindow, r"

        "SUPER, Q, workspace, 1"
        "SUPER, W, workspace, 2"
        "SUPER, F, workspace, 3"
        "SUPER, P, workspace, 4"

        "SUPER_CTRL, Q, movetoworkspace, 1"
        "SUPER_CTRL, W, movetoworkspace, 2"
        "SUPER_CTRL, F, movetoworkspace, 3"
        "SUPER_CTRL, P, movetoworkspace, 4"

        "SUPER, Backspace, exec, pidof wlogout || wlogout -n -b 2"
        "SUPER, L, exec, hyprlock"
      ];

      bindl = [
        ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
    };

    extraConfig = ''
      # window resize
      bind = SUPER, R, submap, resize

      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset
    '';
  };

  #  wayland.windowManager.sway = {
  #    enable = true;
  #
  #    wrapperFeatures.gtk = true;
  #
  #    swaynag.enable = true;
  #
  #    extraSessionCommands = ''
  #      export QT_QPA_PLATFORM=wayland
  #      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
  #    '';
  #
  #    extraConfigEarly = ''
  #      	workspace 1
  #    '';
  #    config = {
  #      modifier = "Mod4";
  #      # Use kitty as default terminal
  #      terminal = "kitty";
  #      defaultWorkspace = "workspace 1";
  #      startup = [
  #        # Launch Firefox on start
  #        { command = "firefox"; }
  #        { command = "hyprlock"; }
  #        {
  #          command = "pkill kanshi; kanshi";
  #          always = true;
  #        }
  #      ];
  #
  #      keybindings =
  #        lib.mkOptionDefault {
  #          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
  #          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
  #          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
  #          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
  #
  #          "XF86MonBrightnessUp" = "exec brightnessctl s +5%";
  #          "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";
  #
  #          "XF86AudioPlay" = "exec playerctl play-pause";
  #          "XF86AudioPause" = "exec playerctl play-pause";
  #        };
  #
  #      window = {
  #        border = 1;
  #        hideEdgeBorders = "smart";
  #        titlebar = false;
  #      };
  #
  #      bars = [
  #        {
  #          command = "waybar";
  #        }
  #      ];
  #
  #      output = {
  #        eDP-1 = {
  #          mode = "2160x1440";
  #          scale = "1.3";
  #        };
  #
  #        "*" = {
  #          bg = "${./black_sand.jpg} fill";
  #        };
  #      };
  #
  #      gaps = {
  #        inner = 10;
  #        outer = 10;
  #        top = 0;
  #        smartBorders = "on";
  #        smartGaps = true;
  #      };
  #
  #      menu = "wofi --show=drun";
  #
  #      floating = {
  #        border = 4;
  #      };
  #
  #      colors = {
  #        background = "#${config.colorScheme.palette.base00}";
  #        focused = {
  #          background = "#${config.colorScheme.palette.base00}";
  #          border = "#${config.colorScheme.palette.base05}";
  #          childBorder = "#${config.colorScheme.palette.base05}";
  #          indicator = "#${config.colorScheme.palette.base05}";
  #          text = "#${config.colorScheme.palette.base05}";
  #        };
  #        focusedInactive = {
  #          background = "#${config.colorScheme.palette.base01}";
  #          border = "#${config.colorScheme.palette.base04}";
  #          childBorder = "#${config.colorScheme.palette.base04}";
  #          indicator = "#${config.colorScheme.palette.base04}";
  #          text = "#${config.colorScheme.palette.base05}";
  #        };
  #        unfocused = {
  #          background = "#${config.colorScheme.palette.base01}";
  #          border = "#${config.colorScheme.palette.base04}";
  #          childBorder = "#${config.colorScheme.palette.base04}";
  #          indicator = "#${config.colorScheme.palette.base04}";
  #          text = "#${config.colorScheme.palette.base05}";
  #        };
  #        urgent = {
  #          background = "#${config.colorScheme.palette.base08}";
  #          border = "#${config.colorScheme.palette.base08}";
  #          childBorder = "#${config.colorScheme.palette.base08}";
  #          indicator = "#${config.colorScheme.palette.base08}";
  #          text = "#${config.colorScheme.palette.base00}";
  #        };
  #        placeholder = {
  #          background = "#${config.colorScheme.palette.base00}";
  #          border = "#${config.colorScheme.palette.base00}";
  #          childBorder = "#${config.colorScheme.palette.base00}";
  #          indicator = "#${config.colorScheme.palette.base00}";
  #          text = "#${config.colorScheme.palette.base05}";
  #        };
  #      };
  #    };
  #  };
}
