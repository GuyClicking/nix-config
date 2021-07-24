{ config, pkgs, lib, ... }:

with builtins;
with lib;

let
  luaConfig = file: ''
    lua << EOF
    ${readFile file}
    EOF
  '';
in
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
        ${readFile ./syntax.vim}

        lua << EOF
          ${readFile ./init.lua}

          function asm()
            vim.bo.ft = 'nasm'
          end
          function c()
            ${readFile ./c.lua}
          end
          function cpp()
            ${readFile ./cpp.lua}
          end
          function lua()
            ${readFile ./lua.lua}
          end
          function tex()
            ${readFile ./tex.lua}
          end
        EOF
        au BufEnter *.asm lua asm()
        au BufEnter *.c lua c()
        au BufEnter *.cpp lua cpp()
        au BufEnter *.lua lua lua()
        au BufEnter *.tex lua tex()
      '';
      plugins = [
        { plugin = config.neovim.colourSchemePackage; config = "colorscheme ${config.neovim.colourScheme}"; }
        { plugin = pkgs.vimPlugins.fugitive; }
        { plugin = pkgs.vimPlugins.fzfWrapper; }
        { plugin = pkgs.vimPlugins.mattn-calendar-vim; }
        { plugin = pkgs.vimPlugins.nvim-compe; config = luaConfig ./compe.lua; }
        { plugin = pkgs.vimPlugins.nvim-lspconfig; }
        { plugin = pkgs.vimPlugins.nvim-treesitter; config = "lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}"; }
        { plugin = pkgs.vimPlugins.plenary-nvim; }
        { plugin = pkgs.vimPlugins.vim-dispatch; }
        { plugin = pkgs.vimPlugins.vim-nix; }
        { plugin = pkgs.vimPlugins.vim-polyglot; }
        { plugin = pkgs.vimPlugins.vim-startify; }
        { plugin = pkgs.vimPlugins.vim-surround; }
        { plugin = pkgs.vimPlugins.vimwiki; }
        { plugin = pkgs.vitalityVimPlugins.LuaSnip; }

        # Language specific plugins
        (mkIf config.haskell.enable { plugin = pkgs.vimPlugins.haskell-vim; })
        (mkIf config.idris2.enable { plugin = pkgs.vimPlugins.idris2-vim; })
        (mkIf config.latex.enable { plugin = pkgs.vimPlugins.vimtex; })
      ];
    };
  };
}
