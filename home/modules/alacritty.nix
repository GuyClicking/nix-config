{ config, pkgs, lib, ... }:

with lib;

let
  mkColourOption = name: default: mkOption {
    type = types.str;
    default = default;
    example = "#123456";
    description = "Colour value for ${name}.";
  };

in
{
  options.alacritty = {
    enable = mkEnableOption "Alacritty";

    font = mkOption {
      type = types.str;
      default = "Hack";
      example = "Hack";
      description = "Font used";
    };

    colours = {
      bg = mkColourOption "bg" "#1d1f21";
      fg = mkColourOption "fg" "#c5c8c6";

      black = mkColourOption "black" "#1d1f21";
      black-bright = mkColourOption "black-bright" "#666666";

      red = mkColourOption "red" "#cc6666";
      red-bright = mkColourOption "red-bright" "#d54e53";

      green = mkColourOption "green" "#b5bd68";
      green-bright = mkColourOption "green-bright" "#b9ca4a";

      yellow = mkColourOption "yellow" "#f0c674";
      yellow-bright = mkColourOption "yellow-bright" "#e7c547";

      blue = mkColourOption "blue" "#81a2be";
      blue-bright = mkColourOption "blue-bright" "#7aa6da";

      magenta = mkColourOption "magenta" "#b294bb";
      magenta-bright = mkColourOption "magenta-bright" "#c397d8";

      cyan = mkColourOption "cyan" "#8abeb7";
      cyan-bright = mkColourOption "cyan-bright" "#70c0b1";

      white = mkColourOption "white" "#c5c8c6";
      white-bright = mkColourOption "white-bright" "#eaeaea";
    };
  };

  config = mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      package = pkgs.hello;

      settings = {
        font = {
          size = 10;
          normal = {
            family = config.alacritty.font;
            style = "Regular";
          };
          bold = {
            family = config.alacritty.font;
            style = "Bold";
          };
          italic = {
            family = config.alacritty.font;
            style = "Italic";
          };
          bold_italic = {
            family = config.alacritty.font;
            style = "Bold Italic";
          };
        };

        colors = {
          primary = {
            background = config.alacritty.colours.bg;
            foreground = config.alacritty.colours.fg;
          };
          normal = {
            black = config.alacritty.colours.black;
            red = config.alacritty.colours.red;
            green = config.alacritty.colours.green;
            yellow = config.alacritty.colours.yellow;
            blue = config.alacritty.colours.blue;
            magenta = config.alacritty.colours.magenta;
            cyan = config.alacritty.colours.cyan;
            white = config.alacritty.colours.white;
          };
          bright = {
            black-bright = config.alacritty.colours.black-bright;
            red-bright = config.alacritty.colours.red-bright;
            green-bright = config.alacritty.colours.green-bright;
            yellow-bright = config.alacritty.colours.yellow-bright;
            blue-bright = config.alacritty.colours.blue-bright;
            magenta-bright = config.alacritty.colours.magenta-bright;
            cyan-bright = config.alacritty.colours.cyan-bright;
            white-bright = config.alacritty.colours.white-bright;
          };
        };
      };
    };
  };
}
