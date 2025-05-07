return {
  -- LSP Servers to be installed by mason-lspconfig
  lsp_servers = {
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
    tsserver = {},
    jsonls = {},
    -- Add more here
  },

  -- Formatters / linters / non-LSP tools to be installed by mason-tool-installer
  tools = {
    'stylua',
    'typescript-language-server',
    'eslint-lsp',
    'prettier', -- If you use prettier
  },
}
