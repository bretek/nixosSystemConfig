{ config, ... }:
{
  programs.waybar = {
    enable = true;

    style = builtins.concatStringsSep "\n" [
      ''
        @define-color background alpha(#${config.colorScheme.palette.base01}, 0.85);
        @define-color focusedButton alpha(#${config.colorScheme.palette.base02}, 0.85);

        @import "${./style.css}";
      ''
    ];

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        width = 1500;

        modules-left = [ "sway/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
          "battery"
        ];

        pulseaudio = {
          "on-click" = "pavucontrol";
        };

        bluetooth = {
          on-click = "blueman-manager";
        };

        network = {
          "format-wifi" = " {icon}";
          "format-ethernet" = "  ";
          "format-disconnected" = "󰌙";
          tooltip = false;
          "format-icons" = [
            "󰤯 "
            "󰤟 "
            "󰤢 "
            "󰤢 "
            "󰤨 "
          ];
        };

        battery = {
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          full-at = 80;
          tooltip = false;
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        clock = {
          "format" = "{:%F %R}";
          tooltip = false;
        };
      };
    };
  };
}
