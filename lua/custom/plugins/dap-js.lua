return {
  'mfussenegger/nvim-dap',
  pin = true,
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {
        'nvim-neotest/nvim-nio',
      },
      opts = {},
    },
    {
      'mxsdev/nvim-dap-vscode-js',
      dependencies = {
        {
          'microsoft/vscode-js-debug',
          build = [[
    npm install --legacy-peer-deps &&
    npx gulp vsDebugServerBundle &&
    powershell -Command "Rename-Item -Path dist -NewName out"
  ]],
        },
      },
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()

    vim.keymap.set('n', '<leader>dw', dap.continue, { desc = '[D]ebug: Start/Continue' })
    vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = '[D]ebug: Quit' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = '[D]ebug: Toggle UI' })
    vim.keymap.set('n', '<leader>ds', dap.step_over, { desc = '[D]ebug: Step Over' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug: Step Into' })
    vim.keymap.set('n', '<leader>do', dap.step_out, { desc = '[D]ebug: Step Out' })
    vim.keymap.set('n', '<leader>dx', function()
      vim.fn.jobstart({
        'powershell.exe',
        '-NoProfile',
        '-Command',
        'Start-Process chrome.exe -ArgumentList "--remote-debugging-port=9222"',
      }, { detach = true })
    end, { desc = '[D]ebug: Launch Chrome with remote port' })

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    ---@diagnostic disable-next-line: missing-fields
    require('dap-vscode-js').setup {
      debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
      adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal', 'pwa-extensionHost' },
    }

    for _, lang in ipairs { 'typescript', 'javascript', 'typescriptreact' } do
      dap.configurations[lang] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-chrome',
          name = 'Attach to Chrome',
          request = 'attach',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,

          url = 'http://localhost:44312',
          protocol = 'inspector',
          port = 9222,
          webRoot = '${workspaceFolder}/wwwroot/js',
        },
      }
    end
  end,
}
