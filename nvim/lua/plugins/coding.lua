return {
  {
    'L3MON4D3/LuaSnip',
    lazy = true,
    version = 'v2.*',
    build = 'make install_jsregexp',
    config = function()
      local luasnip = require('luasnip')
      local types = require('luasnip.util.types')
      luasnip.config.setup({
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = {{ '󰷐', 'Question' }}
            },
            passive = {
              virt_text = {{ '󰷐', 'MoreMsg' }}
            }
          },
          [types.insertNode] = {
            active = {
              virt_text = {{ '', 'Question' }}
            },
            passive = {
              virt_text = {{ '', 'MoreMsg' }}
            }
          }
        }
      })
      luasnip.add_snippets('cpp', require('snippets/cpp'))

      local map = vim.keymap.set;
      map({ 'i' }, '<C-j>', function() luasnip.jump(1) end, { silent = true })
      map({ 'i' }, '<C-k>', function() luasnip.jump(-1) end, { silent = true })
      map({ 'i', 's' }, '<C-n>', function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, { silent = true })
      map({ 'i', 's' }, '<C-p>', function()
        if luasnip.choice_active() then
          luasnip.change_choice(-1)
        end
      end, { silent = true })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      local cmp = require('cmp')
      local cmp_utils = require('utils/cmp_utils')
      local lspkind = require('lspkind');
      cmp.setup({
        enabled = true,
        completion = {
          autocomplete = false,
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
          { name = 'nvim_lsp' }
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
        mapping = cmp.mapping.preset.insert({
          ['<c-space>'] = cmp.mapping.complete(),
          ['<cr>'] = cmp.mapping.confirm({ select = true }),
          ['<c-e>'] = cmp.mapping.abort()
        }),
        -- элемент совпадает только в том случае, если у него совпадает
        -- первая буква с первой буквой набранного слова
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
            before = cmp_utils.format_completion_item
          })
        }
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      padding = true,
      toggler = {
        line = 'gcc',
        block = 'gcb'
      },
      opleader = {
        line = 'gc',
        block = 'gb'
      }
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'printf',
        'python',
        'query',
        'regex',
        'toml',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      }
    }
  },
  -- FIX: example
  -- TODO: example
  -- HACK: example
  -- WARN: example
  -- NOTE: example
  -- PERF: example
  -- TEST: example
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      highlight = {
        before = 'bg',
        keyword = 'wide',
        after = 'bg',
        pattern = [[.*<(KEYWORDS)\s*:]]
      },
      gui_style = {
        fg = "NONE",
        bg = "NONE",
      },
      search = {
        command = 'rg',
        args = {
          '--line-number',
          '--smart-case',
          '--trim',
          '--glob=!.git',
          '--glob=!build',
          '--glob=!target',
          '--glob=!node_modules'
        },
        pattern = [[\b(KEYWORDS):]]
      }
    },
    -- cmd = { 'TodoTelescope' }
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      }
    },
    opts = {
      defaults = {
        initial_mode = 'insert',
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--trim',
          '--glob=!.git',
          '--glob=!build',
          '--glob=!target',
          '--glob=!node_modules'
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case"
        }
      }
    },
    cmd = { 'Telescope', 'TodoTelescope' },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Telescope: Find files' },
      { '<leader>lg', '<cmd>Telescope live_grep<cr>', desc = 'Telescope: Live grep' },
      { '<leader>bf', '<cmd>Telescope buffers<cr>', desc = 'Telescope: Buffers' },
      { '<leader>ht', '<cmd>Telescope help_tags<cr>', desc = 'Telescope: Help tags' },
      { '<leader>mk', '<cmd>Telescope marks<cr>', desc = 'Telescope: Marks' },
      { '<leader>lr', '<cmd>Telescope lsp_references<cr>', desc = 'Telescope: LSP references' },
      { '<leader>dg', '<cmd>Telescope diagnostics<cr>', desc = 'Telescope: Diagnostics' },
      { '<leader>rg', '<cmd>Telescope registers<cr>', desc = 'Telescope: Vim registers' },
      { '<leader>td', '<cmd>TodoTelescope<cr>', desc = 'Telescope: TODO comments' }
    }
  }
}
