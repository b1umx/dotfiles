local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ','

-- Управление окнами
map('n', '<A-\\>', ':vsplit<CR>', opts)
map('n', '<A-/>', ':split<CR>', opts)
map('n', '<A-k>', ':wincmd k<CR>', opts)
map('n', '<A-j>', ':wincmd j<CR>', opts)
map('n', '<A-h>', ':wincmd h<CR>', opts)
map('n', '<A-l>', ':wincmd l<CR>', opts)
map('n', '<A-[>', ':wincmd <<CR>', opts)
map('n', '<A-]>', ':wincmd ><CR>', opts)
map('n', '<A-->', ':wincmd -<CR>', opts)
map('n', '<A-+>', ':wincmd +<CR>', opts)
map('n', '<A-c>', ':wincmd c<CR>', opts)

-- Перемещение строк
map('n', '<A-Down>', ':m .+1<CR>==', opts)
map('n', '<A-Up>', ':m .-2<CR>==', opts)
map('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', opts)
map('v', '<A-Down>', ':m \'>+1<CR>gv=gv', opts)
map('v', '<A-Up>', ':m \'<-2<CR>gv=gv', opts)
map('n', '<Tab>', '>>', opts)
map('n', '<S-Tab>', '<<', opts)
map('v', '<Tab>', '>gv', opts)
map('v', '<S-Tab>', '<gv', opts)

-- Манипуляция с интерфейсом
map('n', '<A-w>', ':w<CR>', { noremap = true, silent = false })
map('n', '<leader>w', ':w<CR>', { noremap = true, silent = false })
map('i', '<A-w>', '<Esc>:w<CR>', { noremap = true, silent = false })
map('n', '<A-q>', ':Bdelete<CR>', opts)
map('n', '<A-Q>', ':qa<CR>', opts)
map('n', '<A-n>', ':set nu! rnu!<CR>', opts)

-- Диагностика
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<A-D>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<A-d>', vim.diagnostic.goto_next, opts)

