-- Catppuccin light theme
require('catppuccin').setup({
    flavour = 'latte',
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15
    },
    styles = {
        conditionals = {},
        keywords = { 'bold' }
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        markdown = true,
        dap = {
            enabled = true,
            enable_ui = true
        },
        telescope = {
            enabled = true
        }
    },
    custom_highlights = function(colors)
        return {
            DapStopped = { fg = colors.green }
        }
    end
})
vim.cmd.colorscheme 'catppuccin'

local palette = require('catppuccin.palettes').get_palette('latte')
vim.api.nvim_set_hl(0, 'SnippetChoiceNode', { fg = palette.yellow })
vim.api.nvim_set_hl(0, 'SnippetInsertNode', { fg = palette.yellow })

local Colors = {
    LspProgressPercentage = palette.sky,
    LspProgressTitle = palette.text,
    LspProgressMessage = palette.subtext0,
    LspProgressSpinner = palette.yellow,
    LspProgressLspClientName = palette.mauve,
}
return Colors

