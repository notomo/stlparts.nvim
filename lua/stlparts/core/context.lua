local vim = vim
local api = vim.api

local M = {}
M.__index = M

function M.new(window_id, hl_group, tab_id)
  local tbl = {
    window_id = window_id or api.nvim_get_current_win(),
    hl_group = hl_group or "StatusLine",
    tab_id = tab_id,
  }
  return setmetatable(tbl, M)
end

function M.width(self)
  if vim.o.laststatus == 3 then
    return vim.o.columns
  end
  return api.nvim_win_get_width(self.window_id)
end

function M.with_window(self, window_id)
  return M.new(window_id, self.hl_group, self.tab_id)
end

function M.with_tab(self, window_id)
  local tab_id = api.nvim_win_get_tabpage(window_id)
  return M.new(window_id, self.hl_group, tab_id)
end

function M.with_highlight(self, hl_group)
  return M.new(self.window_id, hl_group, self.tab_id)
end

return M
