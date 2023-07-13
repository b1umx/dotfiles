require('bufferline').setup({
    options = {
        close_command = 'Bdelete %d',
        right_mouse_command = 'vertical sbuffer %d',
        indicator = {
            style = 'none'
        },
        hover = {
            enabled = true,
            delay = 0,
            reveal = { 'close' }
        },
        modified_icon = '',
        diagnostics = 'nvim_lsp',
        offsets = {
            {
                filetype = 'NvimTree',
                text = '',
                text_align = 'left',
                separator = true
            }
        },
        color_icons = true,
        show_buffer_icons = true,
        separator_style = 'thin',
    },
    highlights = {
        buffer_selected = {
            italic = false
        }
    }
})

local map = vim.api.nvim_set_keymap
map('n', '<A-h>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
map('n', '<A-l>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })

