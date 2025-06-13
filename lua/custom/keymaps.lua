local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Move down 40 lines with 'm'
map('n', 'm', '40j', opts)

-- Move up 40 lines with ','
map('n', ',', '40k', opts)

-- Horizontal split and center
map('n', '<leader>os', ':sp<CR>zz', opts)

-- Vertical split and center
map('n', '<leader>ov', ':vsp<CR>zz', opts)

-- Window navigation
map('n', '<leader>hh', '<C-w>h', opts)
map('n', '<leader>ll', '<C-w>l', opts)
map('n', '<leader>jj', '<C-w>j', opts)
map('n', '<leader>kk', '<C-w>k', opts)

-- Open vertical split to the right
map('n', '<leader>v', ':vsplit<CR>', { desc = 'Open vertical split to the right', silent = true })

-- Open horizontal split below
map('n', '<leader>h', ':split<CR>', { desc = 'Open horizontal split below', silent = true })

-- My custom bookmarks implementaion key maps.
map('n', '<leader>a', function()
  require('custom.bookmarks').add()
end, { desc = 'Bookmark current file', noremap = true, silent = true })

map('n', '<leader>y', function()
  require('custom.bookmarks').list()
end, { desc = 'List bookmarks', noremap = true, silent = true })

map('n', '<leader>r', function()
  require('custom.bookmarks').remove()
end, { desc = 'Remove current file from bookmarks', noremap = true, silent = true })

map('n', '<leader>x', function()
  require('custom.bookmarks').clear()
end, { desc = 'Clear all bookmarks', noremap = true, silent = true })
