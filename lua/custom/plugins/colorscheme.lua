print 'colorscheme plugin loaded'

-- return {
--   'tanvirtin/monokai.nvim',
--   config = function()
--     vim.cmd 'colorscheme monokai'
--   end,
-- }

-- return {
--   'navarasu/onedark.nvim',
--   config = function()
--     require('onedark').setup {
--       style = 'warmer',
--     }
--     -- Enable theme
--     require('onedark').load()
--   end,
-- }

-- return {
--   'eldritch-theme/eldritch.nvim',
--   lazy = false,
--   opts = {},
-- }

return {
  {
    'cpplain/flexoki.nvim',
    lazy = false,
    config = function()
      vim.cmd 'colorscheme flexoki'
    end,
  },
}

-- return {
--   'catppuccin/nvim',
--   name = 'catppuccin',
--   config = function()
--     vim.cmd 'colorscheme catppuccin-mocha'
--   end,
-- }

-- return {
--   'folke/tokyonight.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd 'colorscheme tokyonight-storm'
--   end,
-- }

-- return {
--   {
--     'jacoborus/tender.vim',
--     lazy = false,
--     config = function()
--       vim.opt.termguicolors = true
--       vim.cmd 'colorscheme tender'
--     end,
--   },
-- }
