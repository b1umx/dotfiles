return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local opts = {
        options = {
          theme = 'catppuccin',
          globalstatus = true
        },
        sections = {
          lualine_c = {
            'filename',
            {
              'lsp_progress',
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
      }
      return opts
    end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim'
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
        desc = 'Start Neo-tree with directory',
        once = true,
        callback = function()
          if package.loaded['neo-tree'] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == 'directory' then
              require('neo-tree')
            end
          end
        end,
      })
    end,
    opts = {
      enable_git_status = false,
      window = {
        width = 28
      },
      hijack_netrw_behavior = 'open_default'
    },
    keys = {
      { '<A-f>', '<cmd>Neotree toggle<cr>', desc = 'Sidebar with filesystem (Root Dir)' },
      { '<A-b>', '<cmd>Neotree buffers toggle<cr>', desc = 'Sidebar with openned buffers' },
      { '<A-g>', '<cmd>Neotree git_status toggle<cr>', desc = 'Sidebar with openned git status' }
    }
  },
  {
    'willothy/nvim-cokeline',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      -- 'stevearc/resession.nvim'
    },
    config = true,
    opts = {
      sidebar = {
        filetype = 'neo-tree',
        components = {{
          text = '',
          highlight = 'Normal'
        }}
      }
    }
  }
}
