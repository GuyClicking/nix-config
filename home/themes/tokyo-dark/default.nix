{ pkgs, ... }:

let
  red1 = "#cc241d";
  red2 = "#fb4934";

  green1 = "#98971a";
  green2 = "#b8bb26";

  yellow1 = "#d79921";
  yellow2 = "#fabd24";

  blue1 = "#458588";
  blue2 = "#83a598";

  magenta1 = "#b16286";
  magenta2 = "#d3869b";

  cyan1 = "#689d6a";
  cyan2 = "#8ec07c";

  grey1 = "#a89984";
  grey2 = "#928374";

  orange1 = "#d65d0e";
  orange2 = "#fe8019";

  bg0 = "#11121d";
  bg1 = "#1a1b2a";
  bg2 = "#212234";
  bg3 = "#392b41";
  bg4 = "#4a5057";
  bg5 = "#282c34";

  fg = "#a0a8cd";
in
{
  home.stateVersion = "20.09";

  imports = [ ../../modules ];

  alacritty.colours = {
    bg = bg0_h;
    fg = fg0;

    black = bg0_h;
    black-bright = grey2;

    red = red1;
    red-bright = red2;

    green = green1;
    green-bright = green2;

    yellow = yellow1;
    yellow-bright = yellow2;

    blue = blue1;
    blue-bright = blue2;

    magenta = magenta1;
    magenta-bright = magenta2;

    cyan = cyan1;
    cyan-bright = cyan2;

    white = grey1;
    white-bright = fg1;
  };

  polybar.colours = {
    background = bg0_h;
    background-alt = bg2;
    foreground = fg0;
    foreground-alt = fg4; # bg4?
    alert = red2;
    wm-underline = yellow1;
    date-underline = yellow1;
    battery-underline = yellow1;
  };
}
