{ pkgs, ... }:

{
  home.stateVersion = "20.09";

  imports = [
    modules/alacritty.nix
    modules/starship.nix
    modules/zsh.nix
  ];

  alacritty.enable = true;
  starship.enable = true;
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

  programs = {
    neovim = import ./neovim { inherit pkgs; };
  };
  services.polybar = import ./polybar.nix;

}
