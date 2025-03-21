{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        #after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [{
        timeout = 150; # 2.5min.
        on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
        on-resume = "brightnessctl -r"; # monitor backlight restore.
      }
        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        {
          timeout = 330; # 5.5min
          #on-timeout = hyprctl dispatch dpms off;        # screen off when timeout has passed
          #on-resume = hyprctl dispatch dpms on;          # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }];
    };
  };
}
