return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter', -- load when you first enter Insert mode
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true, -- use treesitter to avoid unwanted pairs
        ts_config = {
          lua = { 'string' }, -- don’t autoclose quotes in lua strings
          javascript = { 'template_string' },
        },
      }
    end,
  },
}
