{ config, pkgs, lib, ... }:

with lib;

{
  options.c = {
    enable = mkEnableOption "C development";
  };

  config = mkIf config.c.enable {
    # Other modules depend on whether this is enabled or not
    home.packages = with pkgs; [
      ccls
      clang-tools
      clang-manpages
      gcc
    ];
  };
}
