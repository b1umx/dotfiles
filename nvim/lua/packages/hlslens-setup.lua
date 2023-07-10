require('hlslens').setup()

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', '<Leader>s', '<Cmd>noh<CR>', opts)
map('n', '<A-s>', '<Cmd>noh<CR>', opts)

