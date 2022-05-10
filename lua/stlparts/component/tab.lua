local M = {}
M.__index = M

--- Make tab component that can be used in tabline.
--- @param tab_number number: tab number
--- @param component function|table: |stlparts.nvim-types-component|
--- @return table: |stlparts.nvim-types-component|
function M.new(tab_number, component)
  local tbl = {
    _built_tab_number = "%" .. tostring(tab_number) .. "T",
    _component = component,
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  return self._built_tab_number .. self._component:build(ctx) .. "%T"
end

return M
