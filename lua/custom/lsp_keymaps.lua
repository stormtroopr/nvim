local M = {}

function M.setup()
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'gD', vim.lsp.buf.declaration, opts)
  map('n', 'gi', vim.lsp.buf.implementation, opts)
  map('n', 'gr', vim.lsp.buf.references, opts)

  -- Organize imports
  map('n', '<leader>oi', function()
    vim.lsp.buf.code_action {
      context = {
        diagnostics = {}, -- Always include this now
        only = { 'source.organizeImports' },
      },
      apply = true,
    }
  end, { desc = 'Organize Imports', noremap = true, silent = true })
end

return M
