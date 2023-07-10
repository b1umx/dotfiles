local cmp = require('cmp')

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 20
local MIN_LABEL_WIDTH = 20

cmp.setup({
    enabled = true,
    completion = {
        -- autocomplete = false,
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
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
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
            else
                fallback()
            end
        end, { 'i', 's' })
    }),
    formatting = {
        format = function(_, vim_item)
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
                vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            elseif string.len(label) < MIN_LABEL_WIDTH then
                local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
                vim_item.abbr = label .. padding
            end
            return vim_item
        end
    }
})

local cmd_mapping = {
    ['<C-Space>'] = {
        c = cmp.complete()
    },
    ['<C-p>'] = {
        c = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end
    },
    ['<C-n>'] = {
        c = function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end
    },
    ['<Tab>'] = {
        c = function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
            else
                fallback()
            end
        end
    },
    ['<C-e>'] = {
        c = cmp.abort()
    }
}

cmp.setup.cmdline(':', {
    mapping = cmd_mapping,
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' }
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmd_mapping,
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
        '--header-insertion=never'
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

