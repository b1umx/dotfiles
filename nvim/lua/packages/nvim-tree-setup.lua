vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local api = require('nvim-tree.api')

require('nvim-tree').setup({
    hijack_cursor = true,
    view = {
        centralize_selection = true,
        preserve_window_proportions = true,
        width = {
            min = 30,
            max = 40
        }
    },
    update_focused_file = {
        enable = true
    },
    renderer = {
        highlight_opened_files = 'all',
        icons = {
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
    },
    on_attach = function(bufnr)
        vim.keymap.set('n', '<A-y>', function()
            local node = api.tree.get_node_under_cursor()
            if node ~= nil then
                vim.fn.setreg('', node.absolute_path)
                vim.fn.setreg('+', node.absolute_path)
            end
        end, { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = 'put the node\'s absolute path to the register' })
    end
})

local map = vim.api.nvim_set_keymap
map('n', '<A-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

local function open_nvim_tree(data)
    local is_directory = vim.fn.isdirectory(data.file) == 1
    if not is_directory then
        return
    end
    vim.cmd.cd(data.file)
    require('nvim-tree.api').tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

