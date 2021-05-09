{ pkgs, ... }:

{
  home.stateVersion = "20.09";

  imports = [ ../../modules ];

  alacritty.colours = {
    bg = "#282a36";
    fg = "#f8f8f2";

    black = "#000000";
    black-bright = "#4d4d4d";

    red = "#ff5555";
    red-bright = "#ff6e67";

    green = "#50fa7b";
    green-bright = "#5af78e";

    yellow = "#f1fa8c";
    yellow-bright = "#f4f99d";

    blue = "#bd93f9";
    blue-bright = "#caa9fa";

    magenta = "#ff79c6";
    magenta-bright = "#ff92d0";

    cyan = "#8be9fd";
    cyan-bright = "#9aedfe";

    white = "#bfbfbf";
    white-bright = "#e6e6e6";
  };

  polybar.colours = {
    background = "#282a36";
    background-alt = "#44475a";
    foreground = "#f8f8f2";
    foreground-alt = "#44475a";
    alert = "#ff5555";
    wm-underline = "#bd93f9";
    date-underline = "#f1fa8c";
    battery-underline = "#50fa7b";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };

  neovim = {
    colourSchemePackage = pkgs.vimPlugins.dracula-vim;
    colourScheme = "dracula";
  };
}
