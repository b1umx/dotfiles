local dap = require('dap')
dap.adapters = {
    lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode',
        name = 'lldb'
    }
}

local lldb = {
    name = "Launch lldb",
    type = "lldb",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false
}

dap.configurations.cpp = { lldb }
dap.configurations.c = { lldb }
dap.configurations.rust = { lldb }

local dap_python = require('dap-python')
dap_python.setup()

vim.keymap.set('n', '<F7>', function() require('dap').continue() end)
vim.keymap.set('n', '<F5>', function() require('dap').terminate() end)
vim.keymap.set('n', '<F8>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F20>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F44>', function() require('dap').step_out() end)
vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dc', function()
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


local dapui = require('dapui')
dapui.setup()
vim.keymap.set('n', '<F9>', function() require('dapui').toggle() end)


