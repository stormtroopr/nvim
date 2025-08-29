return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  opts = {
    on_attach = function(client, bufnr)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
      end

      -- Keys you asked for
      map('n', '<leader>oi', function()
        vim.cmd 'TSToolsOrganizeImports'
      end, 'TS: Organize imports')

      map('n', '<leader>mi', function()
        vim.cmd 'TSToolsAddMissingImports'
      end, 'TS: Add missing imports')

      map('n', '<leader>fa', function()
        vim.cmd 'TSToolsFixAll'
      end, 'TS: Fix all')

      -- Optional - auto organize on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          vim.cmd 'TSToolsOrganizeImports'
        end,
      })
    end,

    settings = {
      separate_diagnostic_server = true,
      publish_diagnostic_on = 'insert_leave',
      tsserver_file_preferences = {
        quotePreference = 'single',
        includeInlayParameterNameHints = 'all',
        includeInlayVariableTypeHints = true,
      },
    },
  },
}
