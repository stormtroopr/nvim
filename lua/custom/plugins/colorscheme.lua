-- return {
--   'tanvirtin/monokai.nvim',
--   config = function()
--     vim.cmd 'colorscheme monokai'
--   end,
-- }

return {
  {
    'cpplain/flexoki.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme flexoki'
    end,
  },
}

-- return {
--   'catppuccin/nvim',
--   name = 'catppuccin',
--   priority = 1000,
--   config = function()
--     vim.cmd 'colorscheme catppuccin-mocha'
--   end,
-- }

-- return {
--   'folke/tokyonight.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd 'colorscheme tokyonight'
--   end,
-- }

-- return {
--   {
--     'jacoborus/tender.vim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.opt.termguicolors = true
--       vim.cmd 'colorscheme tender'
--     end,
--   },
-- }
