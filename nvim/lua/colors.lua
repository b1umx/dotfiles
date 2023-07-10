-- Sonokai
-- vim.g.sonokai_style = 'default'
-- vim.g.sonokai_better_performance = 1
-- vim.g.sonokai_dim_inactive_windows = 1
-- vim.g.sonokai_menu_selection_background = 'green'
-- vim.g.sonokai_diagnostic_virtual_text = 'colored'
-- vim.g.sonokai_better_performance = 1
-- vim.g.sonokai_show_eob = 0
-- vim.cmd.colorscheme 'sonokai'

-- Gruvbox
-- vim.g.background_color = 'medium'
-- vim.cmd.colorscheme 'gruvbox-baby'

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
    }
})
vim.cmd.colorscheme 'catppuccin'

local palette = require('catppuccin.palettes.latte')
vim.api.nvim_set_hl(0, 'SnippetChoiceNode', { fg = palette.lavender })
vim.api.nvim_set_hl(0, 'SnippetInsertNode', { fg = palette.lavender })

