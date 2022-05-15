local M = {}
M.__index = M

function M.new(window_id, hl_group)
  local tbl = {
    window_id = window_id or vim.api.nvim_get_current_win(),
    hl_group = hl_group or "StatusLine",
  }
  return setmetatable(tbl, M)
end

function M.window_width(self)
  if vim.o.laststatus == 3 then
    return vim.o.columns
  end
  return vim.api.nvim_win_get_width(self.window_id)
end

function M.window(self, window_id)
  return M.new(window_id, self.hl_group)
end

function M.highlight(self, hl_group)
  return M.new(self.window_id, hl_group)
end

return M
