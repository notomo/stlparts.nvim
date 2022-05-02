local M = {}
M.__index = M

function M.new(window_id)
  local tbl = { window_id = window_id or vim.api.nvim_get_current_win() }
  return setmetatable(tbl, M)
end

function M.window_width(self)
  if vim.o.laststatus == 3 then
    return vim.o.columns
  end
  return vim.api.nvim_win_get_width(self.window_id)
end

return M
