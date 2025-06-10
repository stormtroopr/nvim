local M = {}
local json = vim.fn.json_encode
local parse = vim.fn.json_decode
local save_path = vim.fn.stdpath 'data' .. '/bookmarks.json'

local function save()
  vim.fn.writefile({ json(M.files) }, save_path)
end

if vim.fn.filereadable(save_path) == 1 then
  local ok, content = pcall(vim.fn.readfile, save_path)
  if ok and content[1] then
    M.files = parse(content[1]) or {}
  else
    M.files = {}
  end
else
  M.files = {}
end

function M.add()
  local path = vim.fn.expand '%:p'
  if not vim.tbl_contains(M.files, path) then
    table.insert(M.files, path)
    save()
    vim.notify('🔖 Added to bookmarks: ' .. vim.fn.fnamemodify(path, ':t'))
  else
    vim.notify('⚠️ File already bookmarked', vim.log.levels.WARN)
  end
end

function M.list()
  local telescope = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local sorters = require('telescope.config').values.generic_sorter
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  telescope
    .new({}, {
      prompt_title = 'Bookmarked Files',
      finder = finders.new_table {
        results = M.files,
        entry_maker = function(entry)
          return {
            value = entry,
            display = vim.fn.fnamemodify(entry, ':t'),
            ordinal = entry,
          }
        end,
      },
      sorter = sorters(),
      attach_mappings = function(_, map)
        map('i', '<CR>', function(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.cmd('edit ' .. selection.value)
        end)
        return true
      end,
    })
    :find()
end

function M.remove()
  local path = vim.fn.expand '%:p'
  for i, p in ipairs(M.files) do
    if p == path then
      table.remove(M.files, i)
      vim.notify('❌ Removed from bookmarks: ' .. vim.fn.fnamemodify(path, ':t'))
      save()
      return
    end
  end
  vim.notify('⚠️ File not in bookmarks', vim.log.levels.WARN)
end

return M
