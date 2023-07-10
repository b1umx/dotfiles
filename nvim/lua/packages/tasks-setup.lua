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

vim.keymap.set('n', '<F5>', '<Cmd>Task start auto build<CR>', { noremap = true, silent = true })

