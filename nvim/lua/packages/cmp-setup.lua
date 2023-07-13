local cmp = require('cmp')
local lspkind = require('lspkind')

local utils = require('packages/cmp-utils')

cmp.setup({
    enabled = true,
    completion = {
        autocomplete = false,
        -- completeopt = 'menu,menuone,noinsert,noselect'
        completeopt = 'menu,menuone,noinsert'
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
    }, {
        { name = 'path' },
        { name = 'buffer' }
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    experimental = {
        native_menu = false,
        ghost_text = false
    },
    mapping = cmp.mapping({
        ['<C-Space>'] = cmp.mapping(utils.toggle_completion, { 'i', 'c', 's' }),
        ['<Up>']      = cmp.mapping(utils.select_prev_item, { 'i', 'c', 's' }),
        ['<Down>']    = cmp.mapping(utils.select_next_item, { 'i', 'c', 's' }),
        ['<C-n>']     = cmp.mapping(utils.select_next_item_or_snippet_choice, { 'i', 'c', 's' }),
        ['<C-p>']     = cmp.mapping(utils.select_prev_item_or_snippet_choice, { 'i', 'c', 's' }),
        ['<Tab>']     = cmp.mapping(utils.confirm_or_snippet_jump, { 'i', 'c', 's' }),
        ['<S-Tab>']   = cmp.mapping(utils.snippet_jump_reverse, { 'i', 'c', 's' })
    }),
    -- элемент совпадает только в том случае, если у него совпадает первая буква с первой буквой
    -- набранного слова
    matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = true
    },
    formatting = {
        fields = {
            cmp.ItemField.Kind,
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu
        },
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            before = utils.format_completion_item
        })
    }
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' }
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    sources = {
        { name = 'buffer' }
    }
})

