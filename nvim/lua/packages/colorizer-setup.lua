require('colorizer').setup()

vim.keymap.set({ 'i', 's' }, '<leader>c', '<Cmd>ColorizerToggle<CR>', { noremap = true, silent = true })

