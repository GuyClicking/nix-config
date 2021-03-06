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
  c.enable = true;
  dunst.enable = true;
  #emacs.enable = true;
  haskell.enable = true;
  idris2.enable = true;
  latex.enable = true;
  polybar.enable = true;
  rofi.enable = true;
  xbindkeys.enable = true;
  xinit = {
    enable = true;
    config = ''
      [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME .Xresources

      . ~/.xprofile

      exec bspwm
    '';
  };
  zathura.enable = true;

  home.packages = with pkgs; [
    # packages
    i3lock-color
    manpages
    tree-sitter
  ];
}
