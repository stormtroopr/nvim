local M = {}
print '>> bookmarks plugin loaded'
local json = vim.fn.json_encode
local parse = vim.fn.json_decode
local project_root = vim.fn.getcwd() -- or use a smarter root finder if you want
local hash = vim.fn.sha256(project_root):sub(1, 8)
local project_name = vim.fn.fnamemodify(project_root, ':t')
local save_path = vim.fn.stdpath 'data' .. '/bookmarks_' .. hash .. '.json'

local fs_realpath = vim.loop.fs_realpath

local function save()
  vim.fn.writefile({ json(M.files) }, save_path)
end

local ok, raw = pcall(vim.fn.readfile, save_path)
if ok and raw[1] then
  local parsed = parse(raw[1])
  if type(parsed) == 'table' and vim.islist(parsed) then
    M.files = parsed
  else
    vim.notify('[bookmarks] Corrupt bookmarks.json, resetting', vim.log.levels.WARN)
    M.files = {}
  end
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
      prompt_title = 'On deck => ' .. vim.fn.fnamemodify(project_name, ':t'),
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

      attach_mappings = function(prompt_bufnr, map)
        local delete_entry = function()
          local selection = action_state.get_selected_entry()
          if not selection then
            return
          end

          -- Remove from M.files
          for i, p in ipairs(M.files) do
            if p == selection.value then
              table.remove(M.files, i)
              save()
              vim.notify('❌ Removed bookmark: ' .. vim.fn.fnamemodify(p, ':t'))
              break
            end
          end

          -- Refresh picker
          actions.close(prompt_bufnr)
          vim.defer_fn(function()
            M.list()
          end, 10)
        end

        map('i', '<CR>', function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.cmd.edit(selection.value)
        end)

        map('n', 'dd', delete_entry)

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
