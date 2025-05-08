return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    -- add others as needed
  },
  config = function()
    local cmp = require 'cmp'

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert {
        ['<CR>'] = cmp.mapping.confirm {
          select = true,
          behavior = cmp.ConfirmBehavior.Insert,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      },
    }
  end,
}
