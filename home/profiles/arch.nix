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

  alacritty = {
    enable = true;
    font = "Hack Nerd Font";
    fontSize = 10;
  };
  programs.alacritty.package = pkgs.hello;
  c.enable = true;
  dunst.enable = true;
  emacs.enable = true;
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
  zsh.aliases = {
    nrh = "nix run .#arch"; # nrh is nix run homemanager
  };

  home.packages = [
    # packages
    pkgs.i3lock-color
    pkgs.manpages
    pkgs.tree-sitter
  ];
}
