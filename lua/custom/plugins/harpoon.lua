return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup {}

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to Harpoon' })

    vim.keymap.set('n', '<leader>y', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open Harpoon quick menu' })

    vim.keymap.set('n', '<C-h>', function()
      harpoon:list():select(1)
    end, { desc = 'Go to first Harpoon file' })

    vim.keymap.set('n', '<C-t>', function()
      harpoon:list():select(2)
    end, { desc = 'Go to second Harpoon file' })

    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():select(3)
    end, { desc = 'Go to third Harpoon file' })

    vim.keymap.set('n', '<C-s>', function()
      harpoon:list():select(4)
    end, { desc = 'Go to fourth Harpoon file' })

    vim.keymap.set('n', '<C-S-<', function()
      harpoon:list():prev()
    end, { desc = 'Go to previous Harpoon file' })

    vim.keymap.set('n', '<C-S->', function()
      harpoon:list():next()
    end, { desc = 'Go to next Harpoon file' })
  end,
}
