local Path = require('plenary.path')
require('tasks').setup({
    default_params = {
        cmake = {
            cmd = 'cmake',
            build_dir = tostring(Path:new('{cwd}', 'build')),
            build_type = 'Debug',
            args = {
                configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' }
            }
        }
    },
    save_before_run = true,
    params_file = 'neovim.json'
})

vim.keymap.set('n', '<leader>tb', '<Cmd>Task start auto build<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tc', '<Cmd>Task start auto configure<CR>', { noremap = true, silent = true })

