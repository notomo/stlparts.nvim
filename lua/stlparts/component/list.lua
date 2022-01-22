local M = {}
M.__index = M

function M.new(component_or_names)
  local components = vim.tbl_map(function(component_or_name)
    return require("stlparts.core.component").get(component_or_name)
  end, component_or_names)
  local tbl = { _components = components }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  local strs = vim.tbl_map(function(c)
    return c:build(ctx)
  end, self._components)
  return table.concat(strs, " ")
end

return M
