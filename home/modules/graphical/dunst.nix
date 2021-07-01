{ config, pkgs, lib, ... }:

with lib;

{
  options.dunst = {
    enable = mkEnableOption "dunst";
  };

  config = mkIf config.dunst.enable {
    home.packages = [ pkgs.dunst pkgs.libnotify ];
    services.dunst = {
      enable = true;
      settings = {
        global.font = "Hack";
      };
    };
  };
}
