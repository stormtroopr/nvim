-- lua/custom/folding.lua
print '>> custom folding loaded'
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    vim.opt_local.foldmethod = 'indent'
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99
  end,
})
