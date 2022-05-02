local M = {}
M.__index = M

--- Separate by '%='. see |statusline|.
--- @param left function|table: |stlparts.nvim-types-component|
--- @param right function|table: |stlparts.nvim-types-component|
--- @return table: |stlparts.nvim-types-component|
function M.new(left, right)
  local tbl = {
    _left = require("stlparts.core.component").get(left),
    _right = require("stlparts.core.component").get(right),
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  return self._left:build(ctx) .. "%=" .. self._right:build(ctx)
end

return M
