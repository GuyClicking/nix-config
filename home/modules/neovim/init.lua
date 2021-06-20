-- vimrc but lua

-- Set leader to space
vim.g.mapleader = ' '

-- Line numbers
-- See :h number_relativenumber
vim.wo.number = true
vim.wo.relativenumber = true

-- Tab configuration
-- See :h tabstop for tab configuration stuff
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smarttab = true

-- Use Australian spelling
vim.bo.spelllang = 'en_au'

-- Ruler shows the line and column number at the bottom right
vim.o.ruler = true

-- Always show the tab bar for consistency
vim.o.showtabline = 2

-- Make underscore separated words separate words
--vim.bo.iskeyword = vim.bo.iskeyword:gsub(",_","")
--vim.o.iskeyword = vim.o.iskeyword:gsub(",_","")

-- Dont wrap long lines
vim.wo.wrap = false

-- Dont highlight searches
vim.o.hlsearch = false

-- Make CTRL-L clear echo and search
vim.api.nvim_set_keymap('n', '<C-L>', ':noh<CR>:mode<CR>',
                        { noremap = true, silent = true })

-- Make leader+a insert one from the end of the line because semicolon
vim.api.nvim_set_keymap('n', '<leader>a', '$i',
                        { noremap = true, silent = true })
-- Make leader+x delete char at the end of the line
vim.api.nvim_set_keymap('n', '<leader>x', '$x',
                        { noremap = true, silent = true })
-- Make leader+f fix the spelling of the current word
vim.api.nvim_set_keymap('n', '<leader>f', '1z=',
                        { noremap = true, silent = true })
-- Make leader+C open the colour scheme menu
vim.api.nvim_set_keymap('n', '<leader>C', ':lua colourscheme()<CR>',
                        { noremap = true, silent = true })
 
-- Make Shift-Delete do nothing (my keyboard is weird so I press it a lot)
vim.api.nvim_set_keymap('i', '<S-Del>', '', { noremap = true, silent = true })

-- Colour column shows the text width of a file
vim.wo.colorcolumn = vim.wo.colorcolumn .. '+' .. 1
for i = 2,255 do vim.wo.colorcolumn = vim.wo.colorcolumn .. ',+' .. i end

-- Funky commands
vim.api.nvim_command('command! W w')

-- Command that opens fzf for colour schemes
function colourscheme()
    vim.api.nvim_eval('fzf#run(fzf#wrap({"source":luaeval("{'..string.gsub(vim.api.nvim_eval("globpath(&rtp, 'colors/*.vim')") .. '\n','.-/colors/(.-).vim\n',"'%1',")..'}"),"sink":"colorscheme"}))')
end

-- LSP

require'lspconfig'.ccls.setup{}
require'lspconfig'.hls.setup{}
require'lspconfig'.texlab.setup{}

-- Always have the sign column so that code doesnt move around on error
vim.wo.signcolumn = "yes"

-- nvim-compe

function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif require'luasnip'.expand_or_jumpable() then
        return t "<Plug>luasnip-expand-or-jump"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif require'luasnip'.expand_or_jumpable() then
        return t "<Plug>luasnip-expand-or-jump"
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Vimwiki
vim.g.vimwiki_list = {{
    path = "~/.local/share/vimwiki/",
    path_html = "~/.local/share/vimwiki-html/",
    auto_toc = 1,
    index = "main"
}}

vim.g.calendar_open = 0

_G.open_calendar = function()
    if vim.g.calendar_open == 1 then
        vim.g.calendar_open = 0
        return t "<Plug>CalendarVq"
    end
    vim.g.calendar_open = 1
    return t "<Plug>CalendarV"
end

vim.api.nvim_set_keymap("n", "<leader>wc", "v:lua.open_calendar()", {expr = true})
