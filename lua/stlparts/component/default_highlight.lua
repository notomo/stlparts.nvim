local M = {}
M.__index = M

--- Set default highlight group to use in children components.
--- @param hl_group string: highlight group
--- @param component function|table: |stlparts.nvim-types-component|
--- @return table: |stlparts.nvim-types-component|
function M.new(hl_group, component)
  local tbl = {
    _hl_group = hl_group,
    _component = require("stlparts.core.component").get(component),
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  return self._component:build(ctx:highlight(self._hl_group))
end

return M
