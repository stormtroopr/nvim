-- Require lspconfig
local lspconfig = require 'lspconfig'

-- Helper function to attach keymaps + organize on save
local on_attach = function(client, bufnr)
  local buf_map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
  end

  -- LSP keymaps
  buf_map('n', 'gd', vim.lsp.buf.definition)
  buf_map('n', 'gD', vim.lsp.buf.declaration)
  buf_map('n', 'gi', vim.lsp.buf.implementation)
  buf_map('n', 'gr', vim.lsp.buf.references)

  -- Auto organize imports on save (only for tsserver)
  if client.name == 'tsserver' then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.code_action {
          context = {
            diagnostics = {},
            only = { 'source.organizeImports' },
          },
          apply = true,
        }
      end,
    })
  end
end

-- Setup tsserver
lspconfig.tsserver.setup {
  on_attach = on_attach,
}
