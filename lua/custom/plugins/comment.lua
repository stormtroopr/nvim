return {
  {
    'numToStr/Comment.nvim',
    -- load when you hit the comment keys
    keys = { 'gc', 'gb' },
    config = function()
      require('Comment').setup {
        -- optional: toggle mapping with leader+/
        toggler = {
          line = '<leader>/',
          block = '<leader>\\',
        },
        -- you can add extra mappings here if you like
      }
    end,
  },
}
