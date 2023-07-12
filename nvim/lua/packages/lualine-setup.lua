local colors = require('colors')

require('lualine').setup({
    options = {
        globalstatus = true
    },
    sections = {
        lualine_c = {
            'filename',
            {
                'lsp_progress',
                colors = {
                    percentage  = colors.LspProgressPercentage,
                    title  = colors.LspProgressTitle,
                    message  = colors.LspProgressMessage,
                    spinner = colors.LspProgressSpinner,
                    lsp_client_name = colors.LspProgressLspClientName,
                    use = true,
                },
                separators = {
                    component = ' ',
                    progress = ' | ',
                    percentage = { pre = '', post = '%% ' },
                    title = { pre = '', post = ': ' },
                    lsp_client_name = { pre = '[', post = ']' },
                    spinner = { pre = '', post = '' },
                    message = { pre = '(', post = ')', commenced = 'In Progress', completed = 'Completed' },
                },
                display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
                timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
                spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
            }
        }
    }
})

