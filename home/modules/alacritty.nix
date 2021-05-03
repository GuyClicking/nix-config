{ config, pkgs, lib, ... }:

with lib;

{
  options.alacritty = {
    enable = mkEnableOption "Alacritty";
  };

  config = mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        font = {
          size = 9;
          normal = {
            family = "Hack";
            style = "Regular";
          };
          bold = {
            family = "Hack";
            style = "Bold";
          };
          italic = {
            family = "Hack";
            style = "Italic";
          };
          bold_italic = {
            family = "Hack";
            style = "Bold Italic";
          };
        };
      };
    };
  };
}
