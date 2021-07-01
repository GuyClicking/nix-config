{ config, pkgs, lib, ... }:

with lib;

{
  options.xinit = {
    enable = mkEnableOption ".xinitrc file";

    config = mkOption {
      type = types.str;
      default = "";
      example = ''
        . ~/.xprofile

        exec bspwm
      '';
      description = "Contents of the ~/.xinitrc file";
    };
  };

  config = mkIf config.xinit.enable {
    home.file.".xinitrc".text = config.xinit.config;
  };
}
