local M = {}
M.__index = M

function M.highlight(hl_group)
  return ("%%#%s#"):format(hl_group)
end

--- Highlight component.
--- @param hl_group string: highlight group
--- @param component function|table: |stlparts.nvim-types-component|
--- @return table: |stlparts.nvim-types-component|
function M.new(hl_group, component)
  local tbl = {
    _hl_group = hl_group,
    _start_hl_group = M.highlight(hl_group),
    _component = require("stlparts.core.component").get(component),
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  return self._start_hl_group .. self._component:build(ctx:highlight(self._hl_group)) .. M.highlight(ctx.hl_group)
end

return M
