vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    hijack_cursor = true,
    view = {
        preserve_window_proportions = true
    },
    renderer = {
        highlight_opened_files = 'all',
        icons = {
            -- glyphs = {
            --     folder = {
            --         arrow_closed = '',
            --         arrow_open = ''
            --     }
            -- },
            show = {
                folder_arrow = false
            },
            git_placement = 'after'
        },
        special_files = {
            'CMakeLists.txt'
        },
        symlink_destination = false
    },
    git = {
        ignore = false
    },
    filters = {
        dotfiles = false
    }
})

local map = vim.api.nvim_set_keymap
map('n', '<A-b>', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
map('n', '<A-B>', ':NvimTreeClose<CR>', { noremap = true, silent = true })

local function open_nvim_tree(data)
    local is_directory = vim.fn.isdirectory(data.file) == 1
    if not is_directory then
        return
    end
    vim.cmd.cd(data.file)
    require('nvim-tree.api').tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

