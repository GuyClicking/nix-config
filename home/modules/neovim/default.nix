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
        au BufEnter *.c lua c()
        au BufEnter *.cpp lua cpp()
        au BufEnter *.lua lua lua()
        au BufEnter *.tex lua tex()
      '';
      plugins = [
        { plugin = pkgs.vimPlugins.vim-nix; }
        { plugin = pkgs.vimPlugins.fzfWrapper; }
        { plugin = pkgs.vimPlugins.idris2-vim; }
        { plugin = pkgs.vimPlugins.haskell-vim; }
        { plugin = pkgs.vitalityVimPlugins.LuaSnip; }
        { plugin = config.neovim.colourSchemePackage; config = "colorscheme ${config.neovim.colourScheme}"; }
        #{ plugin = pkgs.vimPlugins.nvim-compe; config = "lua require'compe'.setup{ enabled=true; autocomplete=true; source={ path=true; nvim_lsp=true; }; }"; }
        { plugin = pkgs.vimPlugins.nvim-compe; config = luaConfig ./compe.lua; }
        { plugin = pkgs.vimPlugins.nvim-lspconfig; }
        { plugin = pkgs.vimPlugins.nvim-treesitter; config = "lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}"; }
        { plugin = pkgs.vimPlugins.vimwiki; }
        { plugin = pkgs.vimPlugins.vimtex; }
        { plugin = pkgs.vimPlugins.fugitive; }
        { plugin = pkgs.vimPlugins.vim-startify; }
        { plugin = pkgs.vimPlugins.vim-dispatch; }
        { plugin = pkgs.vimPlugins.vim-surround; }
        { plugin = pkgs.vimPlugins.vim-polyglot; }
        { plugin = pkgs.vimPlugins.mattn-calendar-vim; }
      ];
    };
  };
}
