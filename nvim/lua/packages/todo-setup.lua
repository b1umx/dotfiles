require('todo-comments').setup({
    highlight = {
        before = '',
        keyword = 'bg',
        after = 'fg'
    },
    search = {
        command = 'rg',
        args = {
            '--line-number',
            '--smart-case',
            '--trim',
            '--glob=!.git',
            '--glob=!build',
            '--glob=!target',
            '--glob=!node_modules'
        }
    }
})

-- TODO: lksdjf

vim.keymap.set('n', '<leader>ftd', '<Cmd>TodoTelescope<CR>', { noremap = true, silent = true })

