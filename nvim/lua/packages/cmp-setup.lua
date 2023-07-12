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
    },
    view = {
        entries = {
            name = 'name',
            selection_order = 'near_cursor'
        }
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


local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = { 'vim', 'use' }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false
            },
            telemetry = {
                enable = false
            }
        }
    }
})

local clangd_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set('n', '<A-o>', ':ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true, buffer = bufnr })
end
lspconfig.clangd.setup({
    on_attach = clangd_on_attach,
    capabilities = capabilities,
    cmd = {
        'clangd',
        '--header-insertion=never',
        '--completion-style=bundled'
    }
})

local path = require('plenary.path')
lspconfig.cmake.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'cmake' },
    buildDirectory = tostring(path:new('{cwd}', 'build'))
})

-- lspconfig.sqlls.setup({
--     -- on_attach = on_attach,
--     -- capabilities = capabilities,
--     cmd = {
--         "sql-language-server",
--         "up",
--         "--method",
--         "stdio"
--     }
-- })

