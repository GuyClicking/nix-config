-- latex ftplugin

-- Bind <leader>+c to ci{ the last {} on the current line
-- e.g. <leader>+c would make \command{ahesifuhisg} \command{} with insert
vim.api.nvim_set_keymap('n', '<leader>c', '$bci{',
                        { noremap = true, silent = true })
