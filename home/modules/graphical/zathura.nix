{ config, pkgs, lib, ... }:

with lib;

{
  options.zathura = {
    enable = mkEnableOption "Zathura";

    colours = {
      bg = mkOption {
        type = types.str;
        default = "#000000";
        example = "#123456";
        description = "Background colour";
      };
      bg2 = mkOption {
        type = types.str;
        default = "#000000";
        example = "#123456";
        description = "Alternative background colour";
      };
      fg = mkOption {
        type = types.str;
        default = "#ffffff";
        example = "#123456";
        description = "Foreground colour";
      };
    };
  };

  config = mkIf config.zathura.enable {
    programs.zathura = {
      enable = true;

      options = {
        selection-clipboard = "clipboard";
        recolor = "true";

        statusbar-bg = config.zathura.colours.bg2;
        statusbar-fg = config.zathura.colours.fg;

        default-bg = config.zathura.colours.bg;
        recolor-lightcolor = config.zathura.colours.bg;

        default-fg = config.zathura.colours.fg;
        recolor-darkcolor = config.zathura.colours.fg;
      };
    };
  };
}
