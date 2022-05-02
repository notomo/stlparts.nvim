local M = {}
M.__index = M

--- Trancate left string by window width.
--- @param component function|table: |stlparts.nvim-types-component|
--- @return table: |stlparts.nvim-types-component|
function M.new(component)
  local ellipsis = ".."
  local tbl = {
    _component = require("stlparts.core.component").get(component),
    _ellipsis = ellipsis,
    _ellipsis_length = vim.fn.strwidth(ellipsis),
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  local str = self._component:build(ctx)
  local width = vim.fn.strwidth(str)
  local max_width = vim.api.nvim_win_get_width(ctx.window_id)
  if max_width < width then
    return ".." .. vim.fn.strpart(str, width - max_width + self._ellipsis_length)
  end
  return str
end

return M
