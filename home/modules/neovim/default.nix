{ config, pkgs, lib, ... }:

with lib;

{
  options.neovim = {
    enable = mkEnableOption "Neovim";

    colourSchemePackage = mkOption {
      type = types.package;
      default = pkgs.vimPlugins.gruvbox;
      example = pkgs.vimPlugins.dracula-vim;
      description = "Package of the vim colour scheme used.";
    };

    colourScheme = mkOption {
      type = types.str;
      default = "gruvbox";
      example = "blue";
      description = "What you would type in the colorscheme vim command (e.g. `colorscheme gruvbox`).";
    };
  };

  config = mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim;
      extraConfig = ''
        lua << EOF
          ${builtins.readFile ./init.lua}

          function c()
            ${builtins.readFile ./c.lua}
          end
          function cpp()
            ${builtins.readFile ./cpp.lua}
          end
          function lua()
            ${builtins.readFile ./lua.lua}
          end
          function tex()
            ${builtins.readFile ./tex.lua}
          end
        EOF
        au BufEnter *.c lua c()
        au BufEnter *.cpp lua cpp()
        au BufEnter *.lua lua lua()
        au BufEnter *.tex lua tex()
      '';
      plugins = [
        { plugin = pkgs.vimPlugins.vim-nix; }
        { plugin = pkgs.vimPlugins.fzfWrapper; }
        { plugin = pkgs.vimPlugins.idris2-vim; }
        { plugin = config.neovim.colourSchemePackage; config = "colorscheme ${config.neovim.colourScheme}"; }
        { plugin = pkgs.vimPlugins.nvim-lspconfig; }
        { plugin = pkgs.vimPlugins.nvim-treesitter; config = "lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}"; }
      ];
    };
  };
}
