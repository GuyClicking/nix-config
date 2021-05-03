{ config, pkgs, lib, ... }:

with lib;

{
  options.starship = {
    enable = mkEnableOption "Starship";
  };

  config = mkIf config.starship.enable {
    programs.starship = {
      enable = true;

      settings = {
        add_newline = false;
      };
    };
  };
}
