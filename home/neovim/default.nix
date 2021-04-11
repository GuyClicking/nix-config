{ pkgs, ... }:

{
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
    EOF
    au BufEnter *.c lua c()
    au BufEnter *.cpp lua cpp()
    au BufEnter *.lua lua lua()
  '';
  plugins = with pkgs.vimPlugins; [
    { plugin = vim-nix; }
    { plugin = idris2-vim; }
    { plugin = gruvbox; config = "colorscheme gruvbox"; }
    { plugin = nvim-lspconfig; }
    { plugin = nvim-treesitter; config = "lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}"; }
  ];
}
