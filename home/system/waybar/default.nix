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
        max-width = 1500;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
          "battery"
        ];

        pulseaudio = {
          format = "  {volume}%";
          on-click = "pavucontrol";
        };

        bluetooth = {
          format-off = "󰂲";
          format-on = "󰂯";
          format-connected = "({num_connections}) 󰂱";
          format-connected-battery = "({num_connections}) 󰂱 {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n{num_connections} connected\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        network = {
          "format-wifi" = " {icon}";
          "format-ethernet" = "󰌙";
          "format-disconnected" = "";
          tooltip = false;
          "format-icons" = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤢"
            "󰤨"
          ];
        };

        battery = {
          format = "{icon}  {capacity}%";
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
