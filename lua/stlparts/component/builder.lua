local M = {}
M.__index = M

--- Build components dynamically.
--- @param create_component function: |stlparts.nvim-types-component|
--- @return table: |stlparts.nvim-types-component|
function M.new(create_component)
  local tbl = {
    _create_component = create_component,
  }
  return setmetatable(tbl, M)
end

local get = require("stlparts.core.component").get

function M.build(self, ctx)
  local component = self._create_component(ctx)
  return get(component):build(ctx)
end

return M
