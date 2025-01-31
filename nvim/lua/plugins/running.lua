return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-dap-19',
        name = 'lldb'
      }

      local lldb = {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      }
      dap.configurations.cpp = { lldb }
      dap.configurations.c = { lldb }
      dap.configurations.rust = { lldb }

      vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
      vim.keymap.set('n', '<leader>dt', function() require('dap').terminate() end)
      vim.keymap.set('n', '<leader>dn', function() require('dap').step_over() end)
      vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end)
      vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end)
      vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
      vim.keymap.set('n', '<leader>da', function()
        local condition = vim.fn.input('Breakpoint condition: ')
        require('dap').toggle_breakpoint(condition)
      end)
      vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
      vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

      local sign = vim.fn.sign_define
      sign('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = ''})
      sign('DapBreakpointCondition', { text = '', texthl = 'DapBreakpointCondition', linehl = '', numhl = ''})
      sign('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = ''})
      sign('DapStopped', { text = '', texthl = 'DapStopped', linehl = '', numhl = ''})
      sign('DapBreakpointRejected', { text = '', texthl = 'DapBreakpointRejected', linehl = '', numhl = ''})
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio'
    },
    config = function()
      local dapui = require('dapui')
      dapui.setup()
      vim.keymap.set('n', '<leader>dv', function()
        require('neo-tree.command').execute({ action = 'close' })
        require('dapui').open()
      end)
      vim.keymap.set('n', '<leader>de', function()
        require('dapui').close()
        require('neo-tree.command').execute({ action = 'show' })
      end)
    end
  }
}
