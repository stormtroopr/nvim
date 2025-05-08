return {
  'stevearc/conform.nvim',
  opts = {
    -- Enable format on save
    format_on_save = function(bufnr)
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size < 100 * 1024 then
        return { timeout_ms = 500, lsp_fallback = true }
      end
    end,

    -- Use prettier for CSS/Sass/SCSS
    formatters_by_ft = {
      css = { 'prettier' },
      scss = { 'prettier' },
      sass = { 'prettier' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      json = { 'prettier' },
      html = { 'prettier' },
    },
  },
}
