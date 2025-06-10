return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'mxsdev/nvim-dap-vscode-js',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup()
      require('nvim-dap-virtual-text').setup()

      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/vscode-js-debug',
        adapters = { 'pwa-chrome' },
      }

      vim.keymap.set('n', '<F5>', function()
        dap.continue()
      end)

      for _, lang in ipairs {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      } do
        dap.configurations[lang] = {
          {
            name = 'Attach to Chrome',
            type = 'pwa-chrome',
            request = 'attach',
            cwd = vim.fn.getcwd(),
            program = '${file}',
            webRoot = '${workspaceFolder}/wwwroot/js',
            urlFilter = 'https://localhost:44312/models',
          },
        }
      end
    end,
  },
}
