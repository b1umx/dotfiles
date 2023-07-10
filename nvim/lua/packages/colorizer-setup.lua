require('colorizer').setup()

vim.keymap.set({ 'n' }, '<leader>c', '<Cmd>ColorizerToggle<CR>', { noremap = true, silent = true })

