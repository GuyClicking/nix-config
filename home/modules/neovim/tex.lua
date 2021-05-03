-- latex ftplugin

-- Set the text width to 79 characters
vim.bo.textwidth = 79

-- Enable spell checking
vim.wo.spell = true

-- Bind <leader>+c to ci{ the last {} on the current line
-- e.g. <leader>+c would make \command{ahesifuhisg} \command{} with insert
vim.api.nvim_set_keymap('n', '<leader>c', '$bci{',
                        { noremap = true, silent = true })

-- Bind <leader>+d to duplicate the current line down
vim.api.nvim_set_keymap('n', '<leader>d', 'yyp',
                        { noremap = true, silent = true })
