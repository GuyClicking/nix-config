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

    zsh = import ./zsh.nix { inherit pkgs; };

    starship = import ./starship.nix;
  };
  services.polybar = import ./polybar.nix;

}
