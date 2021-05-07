{ pkgs, ... }:

{
  home.stateVersion = "20.09";

  imports = [
    ./modules
  ];

  alacritty.enable = true;
  neovim.enable = true;
  polybar.enable = true;
  starship.enable = true;
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
    pkgs.ccls
    pkgs.gcc
    pkgs.i3lock-color
    pkgs.tree-sitter
  ];

#  gtk = {
#    enable = true;
#    theme = {
#      package = pkgs.gruvbox-dark-gtk;
#      name = "Gruvbox Dark";
#    };
#  };
}
