return {
  'nvim-treesitter/nvim-treesitter',
  opts = function(_, opts)
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- Ensure parser is ready before setting folds
        local ok = pcall(vim.treesitter.get_parser, 0)
        if ok then
          vim.opt.foldmethod = 'expr'
          vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
          vim.opt.foldenable = false -- don't collapse by default
        end
      end,
    })
  end,
}
