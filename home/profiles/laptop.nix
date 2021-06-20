{ pkgs, ... }:

{
  home.stateVersion = "20.09";

  imports = [
    ../modules
    ../themes/gruvbox
  ];

  alacritty.enable = true;
  dunst.enable = true;
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
    pkgs.haskell-language-server
    pkgs.i3lock-color
    pkgs.manpages
    pkgs.texlab
    pkgs.tree-sitter
  ];
}
