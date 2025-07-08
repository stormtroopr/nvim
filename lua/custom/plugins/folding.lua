-- lua/custom/plugins/folding.lua

return {
  'nvim-treesitter/nvim-treesitter', -- or any always-loaded plugin
  init = function()
    vim.opt.foldmethod = 'indent'
    vim.opt.foldenable = true
    vim.opt.foldlevel = 99
    vim.notify 'Folding settings applied'
  end,
}
