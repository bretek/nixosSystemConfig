{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.keyd
  ];

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          tab = "layer(shift)";
          enter = "space";

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
        };
      };
    };
  };
}

