local M = {}
M.__index = M

function M.new(window_id)
  local tbl = { window_id = window_id or vim.api.nvim_get_current_win() }
  return setmetatable(tbl, M)
end

return M
