local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gp', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<leader>hv', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<leader>tp', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>ft', function() vim.lsp.buf.format { async = true } end, opts)
end

return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim', 'use' }},
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false
            },
            telemetry = { enable = false }
          }
        }
      })

      local clangd_on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.keymap.set('n', '<A-o>', '<cmd>ClangdSwitchSourceHeader<cr>', { noremap = true, silent = true, buffer = bufnr })
        vim.keymap.set('n', '<A-i>', '<cmd>ClangdShowSymbolInfo<cr>', { noremap = true, silent = true, buffer = bufnr })
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

      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })
    end
  },
}
