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

  home.file = scripts;

  alacritty = {
    enable = true;
    font = "Hack Nerd Font";
  };
  dunst.enable = true;
  haskell.enable = true;
  latex.enable = true;
  polybar.enable = true;
  zathura.enable = true;
  xbindkeys.enable = true;
  xinit = {
    enable = false;
    config = ''
      [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME .Xresources

      . ~/.xprofile

      exec bspwm
    '';
  };

  home.packages = [
    # packages
    pkgs.ccls
    pkgs.i3lock-color
    pkgs.manpages
    pkgs.tree-sitter
  ];
}
