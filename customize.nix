{ pkgs, ... }:

pkgs.writeShellScriptBin "customize" ''


echo 'Pick a colour scheme'
theme=$(echo -e 'gruvbox\ndracula' | ${pkgs.fzf}/bin/fzf --reverse --height 10%)
somehow import home/themes/$theme in home flake
''
