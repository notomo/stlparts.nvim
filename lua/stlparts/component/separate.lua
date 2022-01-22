local M = {}
M.__index = M

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
