local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

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
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts)
end

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
        '--completion-style=detailed',
        '--all-scopes-completion'
    }
})

local path = require('plenary.path')
lspconfig.cmake.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'cmake' },
    buildDirectory = tostring(path:new('{cwd}', 'build'))
})

lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

