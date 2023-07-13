local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ','

-- Управление окнами
map('n', '<A-\\>', ':vsplit<CR>', opts)
map('n', '<A-/>', ':split<CR>', opts)
map('n', '<A-Up>', ':wincmd k<CR>', opts)
map('n', '<A-Down>', ':wincmd j<CR>', opts)
map('n', '<A-Left>', ':wincmd h<CR>', opts)
map('n', '<A-Right>', ':wincmd l<CR>', opts)
map('n', '<A-S-Left>', ':wincmd <<CR>', opts)
map('n', '<A-S-Right>', ':wincmd ><CR>', opts)
map('n', '<A-S-Up>', ':wincmd -<CR>', opts)
map('n', '<A-S-Down>', ':wincmd +<CR>', opts)
map('n', '<A-c>', ':wincmd c<CR>', opts)

-- Перемещение строк
map('n', '<A-j>', ':m .+1<CR>==', opts)
map('n', '<A-k>', ':m .-2<CR>==', opts)
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)
map('v', '<A-j>', ':m \'>+1<CR>gv=gv', opts)
map('v', '<A-k>', ':m \'<-2<CR>gv=gv', opts)
map('n', '<Tab>', '>>', opts)
map('n', '<S-Tab>', '<<', opts)
map('v', '<Tab>', '>gv', opts)
map('v', '<S-Tab>', '<gv', opts)

-- Манипуляция с интерфейсом
map('n', '<C-s>', ':w<CR>', { noremap = true, silent = false })
map('n', '<leader>s', ':w<CR>', { noremap = true, silent = false })
map('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = false })
map('n', '<A-q>', ':Bdelete<CR>', opts)
map('n', '<A-e>', ':qa<CR>', opts)
map('n', '<A-n>', ':set nu! rnu!<CR>', opts)

-- Диагностика
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<A-D>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<A-d>', vim.diagnostic.goto_next, opts)

