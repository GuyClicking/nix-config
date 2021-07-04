{ config, pkgs, lib, ... }:

with lib;

{
  options.emacs = {
    enable = mkEnableOption "Emacs";
  };

  config = mkIf config.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacsPgtkGcc;

      extraPackages = epkgs: [
        epkgs.gruvbox-theme
      ];
    };

    services.emacs.enable = true;
  };
}
