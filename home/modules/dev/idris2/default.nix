{ config, pkgs, lib, ... }:

with lib;

{
  options.idris2 = {
    enable = mkEnableOption "idris2";
  };

  config = mkIf config.idris2.enable {
    home.packages = [
      pkgs.idris2
      #(pkgs.idris2.withPackages (ps: with ps; [ idris2api ]))
      #(pkgs.idris2.packages.lsp.withPackages (ps: with ps; [ idris2api ]))
      #(import ./lsp.nix)
    ];
  };
}
