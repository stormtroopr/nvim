local M = {}
local json = vim.fn.json_encode
local parse = vim.fn.json_decode
local save_path = vim.fn.stdpath 'data' .. '/bookmarks.json'
local fs_realpath = vim.loop.fs_realpath

local function save()
  vim.fn.writefile({ json(M.files) }, save_path)
end

local ok, raw = pcall(vim.fn.readfile, save_path)
if ok and raw[1] then
  local parsed = parse(raw[1])
  M.files = type(parsed) == 'table' and parsed or {}
else
  M.files = {}
end

function M.add()
  local raw_path = vim.fn.expand '%:p'
  local path = fs_realpath(raw_path) or raw_path

  for _, p in ipairs(M.files) do
    if fs_realpath(p) == path then
      vim.notify('⚠️ File already bookmarked', vim.log.levels.WARN)
      return
    end
  end

  table.insert(M.files, path)
  save()
  vim.notify('🔖 Added to bookmarks: ' .. vim.fn.fnamemodify(path, ':t'))
end

function M.list()
  local telescope = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local sorters = require('telescope.config').values.generic_sorter
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local visible_files = vim.tbl_filter(function(path)
    return vim.fn.filereadable(path) == 1
  end, M.files)

  telescope
    .new({}, {
      prompt_title = 'MLC73 On deck',
      finder = finders.new_table {
        results = visible_files,
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

          local ok, err = pcall(function()
            vim.cmd('edit ' .. selection.value)
          end)

          if not ok then
            vim.notify('Failed to open file: ' .. err, vim.log.levels.ERROR)
          end
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

function M.clear()
  M.files = {}
  save()
  vim.notify '🧹 Cleared all bookmarks'
end

return M
