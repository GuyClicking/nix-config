require'compe'.setup{
    enabled = true;
    autocomplete = true;
    preselect = 'enable';
    source = {
        buffer = true;
        luasnip = true;
        nvim_lsp = true;
        nvim_lua = true;
    };
}
