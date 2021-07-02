{ config, pkgs, lib, ... }:

with lib;

{
  options.rofi = {
    enable = mkEnableOption "Rofi";

    theme = mkOption {
      type = types.nullOr types.string;
      default = null;
      example = "gruvbox-dark-hard";
      description = "Theme from rofi-theme-selector";
    };

    borderWidth = mkOption  {
      type = types.nullOr types.int;
      default = null;
      example = 1;
      description = "Border Width";
    };

    font = mkOption {
      type = types.str;
      default = "Hack 10";
      example = "Hack 10";
      description = "Font used";
    };

    padding = mkOption {
      type = types.nullOr types.int;
      default = null;
      example = 400;
      description = "Padding";
    };

    scrollbar = mkOption {
      type = types.nullOr types.bool;
      default = null;
      example = true;
      description = "Whether or not the scrollbar should be shown";
    };

    separator = mkOption {
      type = types.nullOr types.oneOf [ "none" "dash" "solid" ];
      default = null;
      example = "solid";
      description = "Separator style";
    };

    location = mkOption {
      type = types.oneOf [ 
        "bottom"
        "bottom-left"
        "bottom-right"
        "center"
        "left"
        "right"
        "top"
        "top-left"
        "top-right"
      ];
      default = "center";
      description = "The default location of rofi on the screen";
    };

    width = mkOption {
      type = types.nullOr types.int;
      default = null;
      example = 100;
      description = "Width of the window";
    };

    xoffset = mkOption {
      type = types.int;
      default = 0;
      example = 50;
      description = "Translate the window by this many pixels along the x axis";
    };

    yoffset = mkOption {
      type = types.int;
      default = 0;
      example = 50;
      description = "Translate the window by this many pixels along the y axis";
    };

    lines = mkOption {
      type = types.nullOr types.int;
      default = null;
      example = 10;
      description = "Number of lines";
    };

    rowHeight = mkOption {
      type = types.nullOr types.int;
      default = null;
      example = 1;
      description = "Height of each row in chars";
    };

    terminal = mkOption {
      type = types.nullOr types.string;
      default = null;
      example = "${pkgs.alacritty}/bin/alacritty";
      description = "Path to terminal";
    };
  };

  config = mkIf config.rofi.enable {
    programs.rofi = {
      enable = true;

      theme = config.rofi.theme;

      borderWidth = config.rofi.borderWidth;

      font = config.rofi.font;
      #padding = config.rofi.padding;
      #scrollbar = config.rofi.scrollbar;
      #separator = config.rofi.separator;
      #location = config.rofi.location;
      #width = config.rofi.width;
      #xoffset = config.rofi.xoffset;
      #yoffset = config.rofi.yoffset;

      lines = config.rofi.lines;
      rowHeight = config.rofi.rowHeight;

      terminal = config.rofi.terminal;

      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
      ];

      extraConfig = {
        modi = "calc,combi,drun,emoji,run,ssh";
      };
    };
  };
}
