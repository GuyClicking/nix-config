{ config, pkgs, lib, ... }:

with lib;

{
  options.haskell = {
    enable = mkEnableOption "Haskell";
  };

  # im 99% sure this wont be helpful but eh
  config = mkIf config.haskell.enable {
    home.packages = with pkgs; [
      ghc
      haskell-language-server
    ];
  };
}
