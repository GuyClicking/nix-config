{ pkgs, lib, ... }:

with lib;
let
  libExtra = import ../../lib { inherit lib; };
  scripts = libExtra.mapOnDirRec ../scripts (name: a:
    libExtra.createScriptFile name "${toString ../scripts}/${name}"
  );
in {
  home.stateVersion = "20.09";

  imports = [
    ../modules
    ../themes/gruvbox
  ];

  home.file = scripts;

  alacritty.enable = true;
  dunst.enable = true;
  git.enable = true;
  idris2.enable = true;
  neovim.enable = true;
  polybar.enable = true;
  starship.enable = true;
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
  zsh = {
    enable = true;
    editor = "nvim";
  };

  home.packages = [
    # packages
    pkgs.bc
    pkgs.ccls
    pkgs.fzf
    pkgs.gcc
    pkgs.i3lock-color
    pkgs.manpages
    pkgs.texlab
    pkgs.tree-sitter
  ];
}
