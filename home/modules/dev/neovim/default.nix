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
      plugins = with pkgs.vimPlugins; with pkgs.vitalityVimPlugins; [
        { plugin = config.neovim.colourSchemePackage; config = "colorscheme ${config.neovim.colourScheme}"; }
        { plugin = fugitive; }
        { plugin = fzfWrapper; }
        { plugin = LuaSnip; }
        { plugin = mattn-calendar-vim; }
        { plugin = nvim-compe; config = luaConfig ./compe.lua; }
        { plugin = nvim-lspconfig; }
        { plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars); config = "lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}"; }
        { plugin = telescope-nvim; config = luaConfig ./telescope.lua; }
        { plugin = telescope-bibtex-nvim; }
        { plugin = telescope-cheat-nvim; }
        { plugin = telescope-frecency-nvim; }
        { plugin = telescope-symbols-nvim; }
        { plugin = telescope-fzy-native-nvim; }
        { plugin = plenary-nvim; }
        { plugin = popup-nvim; }
        { plugin = vim-dispatch; }
        { plugin = vim-nix; }
        { plugin = vim-polyglot; }
        { plugin = vim-startify; }
        { plugin = vim-surround; }
        { plugin = vimwiki; }

        # Language specific plugins
        (mkIf config.haskell.enable { plugin = haskell-vim; })
        (mkIf config.idris2.enable { plugin = idris2-vim; })
        (mkIf config.latex.enable { plugin = vimtex; })
      ];
    };
  };
}
