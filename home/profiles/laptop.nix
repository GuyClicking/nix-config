{ pkgs, lib, ... }:

with lib;
let
  libExtra = import ../../lib { inherit lib; };
in
{
  home.stateVersion = "20.09";

  imports = [
    ./minimal.nix
    ../themes/gruvbox
  ];

  alacritty.enable = true;
  dunst.enable = true;
  idris2.enable = true;
  polybar.enable = true;
  rofi.enable = true;
  zathura.enable = true;
  xbindkeys.enable = true;
  xinit = {
    enable = true;
    config = ''
      [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME .Xresources

      . ~/.xprofile

      exec bspwm
    '';
  };

  home.packages = with pkgs; [
    # packages
    ccls
    i3lock-color
    manpages
    tree-sitter
  ];
}
