-- in your plugins spec
return {
  'mg979/vim-visual-multi',
  branch = 'master',
  init = function()
    -- VSCode-like keys
    vim.g.VM_default_mappings = 0
    vim.g.VM_leader = '\\'
    vim.g.VM_maps = {
      ['Find Under'] = '<C-d>', -- add next occurrence
      ['Find Subword Under'] = '<C-d>',
      ['Skip Region'] = '<C-l>', -- skip this occurrence
      ['Remove Region'] = '<C-u>', -- remove this occurrence
      ['Add Cursor Down'] = '<A-j>',
      ['Add Cursor Up'] = '<A-k>',
    }
  end,
}
