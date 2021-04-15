{ pkgs, ... }:

{
  home.stateVersion = "20.09";

  home.packages = [
    # packages
    pkgs.ccls
    pkgs.gcc
    pkgs.i3lock-color
    pkgs.tree-sitter
  ];

  programs = {
    alacritty = import ./alacritty.nix;

    neovim = import ./neovim { inherit pkgs; };

    #polybar = import ./polybar.nix;

    zsh = import ./zsh.nix { inherit pkgs; };

    starship = import ./starship.nix;
  };
}
