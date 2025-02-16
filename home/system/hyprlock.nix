{ config, ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        disable_loading_bar = true;
      };
      auth = {
        fingerprint = {
          enabled = true;
        };
      };
      background = {
        path = "${./black_sand.jpg}";
      };

      label = {
        text = "cmd[update:1000] echo $TIME";
        color = "rgb(${config.colorScheme.palette.base05})";
        font_size = 80;
        position = "0, 100";
        halign = "center";
        valign = "center";
      };

      input-field = {
        size = "230, 40";
        outline_thickness = 0;
        dots_size = 0.2;
        dots_spacing = 0.4;
        dots_center = true;
        inner_color = "rgb(${config.colorScheme.palette.base01})";
        check_color = "rgb(${config.colorScheme.palette.base01})";
        font_color = "rgb(${config.colorScheme.palette.base05})";
        fade_on_empty = false;
        placeholder_text = "Enter password...";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        hide_input = false;
        position = "0, -50";
        halign = "center";
        valign = "center";
      };
    };
  };
}
