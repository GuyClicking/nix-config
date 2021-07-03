{ pkgs, lib, ... }:

with lib;
let
  libExtra = import ../../lib { inherit lib; };
  scripts = libExtra.mapOnDirRec ../scripts (name: a:
    libExtra.createScriptFile name "${toString ../scripts}/${name}"
  );
in
{
  home.stateVersion = "20.09";

  imports = [
    ../modules
  ];

  home.file = scripts;

  git.enable = true;
  neovim.enable = true;
  starship.enable = true;
  zsh = {
    enable = true;
    editor = "nvim";
  };

  home.packages = with pkgs; [
    bc
    fzf
    gcc
  ];
}
