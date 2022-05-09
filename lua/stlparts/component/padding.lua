local M = {}
M.__index = M

--- Add padding.
--- @param component function|table: |stlparts.nvim-types-component|
--- @param opts table|nil: default: {left = 1, right = 1}
--- @return table: |stlparts.nvim-types-component|
function M.new(component, opts)
  opts = opts or {}
  local left = (" "):rep(opts.left or 1)
  local right = (" "):rep(opts.right or 1)
  local tbl = {
    _component = require("stlparts.core.component").get(component),
    _left = left,
    _right = right,
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  return self._left .. self._component:build(ctx) .. self._right
end

return M
