require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'c',
        'lua',
        'vim',
        'help',
        'query',
        'cpp',
        'hlsl',
        'rust',
        'python',
        'bash',
        'cmake',
        'diff',
        'dockerfile',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'html',
        'http',
        'ini',
        'javascript',
        'json',
        'json5',
        'jsonc',
        'make',
        'markdown',
        'markdown_inline',
        'regex',
        'scss',
        'css',
        'sql',
        'thrift',
        'todotxt',
        'toml',
        'typescript',
        'yaml'
    },
    highlight = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    indent = {
        enable = true
    }
})

