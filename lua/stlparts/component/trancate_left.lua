local M = {}
M.__index = M

--- Trancate left string by window width.
--- @param component function|table: |stlparts.nvim-types-component|
--- @param opts table|nil: default: {max_width = function(ctx) return ctx:window_width() end, ellipsis = ".."}
--- @return table: |stlparts.nvim-types-component|
function M.new(component, opts)
  opts = opts or {}
  local ellipsis = opts.ellipsis or ".."
  local tbl = {
    _component = require("stlparts.core.component").get(component),
    _ellipsis = ellipsis,
    _ellipsis_length = vim.fn.strwidth(ellipsis),
    _max_width = opts.max_width or function(ctx)
      return ctx:window_width()
    end,
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  local str = self._component:build(ctx)
  local width = vim.fn.strwidth(str)
  local max_width = self._max_width(ctx)
  if max_width < width then
    return self._ellipsis .. vim.fn.strpart(str, width - max_width + self._ellipsis_length)
  end
  return str
end

return M
