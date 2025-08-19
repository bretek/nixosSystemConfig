{ config, ... }:
{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "hyprlock";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "reboot";
        keybind = "r";
      }
      {
        label = "logout";
        action = "hyprland exit";
        keybind = "o";
      }
      {
        label = "shutdown";
        action = "shutdown now";
        keybind = "s";
      }
    ];

    style = builtins.concatStringsSep "\n" [
      ''
              @define-color background #${config.colorScheme.palette.base01};
              @define-color highlight #${config.colorScheme.palette.base02};

              #lock {
            background-image: image(url("${./icons/lock.png}"));
        }
              #reboot {
            background-image: image(url("${./icons/reboot.png}"));
        }
              #logout {
            background-image: image(url("${./icons/logout.png}"));
        }
              #shutdown {
            background-image: image(url("${./icons/shutdown.png}"));
        }

              @import "${./style.css}";
      ''
    ];
  };
}
