{ config, pkgs, lib, ... }:

with lib;

{
  options.latex = {
    enable = mkEnableOption "Latex";
  };

  config = mkIf config.latex.enable {
    home.packages = with pkgs; [
      pgfplots
      texlab
      texlive.combined.scheme-full
    ]
  };
}
