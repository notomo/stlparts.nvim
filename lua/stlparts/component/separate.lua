local M = {}
M.__index = M

--- Separate each components by '%='. see |statusline|.
--- @param components table[]: list of |stlparts.nvim-types-component|
--- @return table: |stlparts.nvim-types-component|
function M.new(components)
  local tbl = {
    _components = vim.tbl_map(function(c)
      return require("stlparts.core.component").get(c)
    end, components),
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  local strs = vim.tbl_map(function(c)
    return c:build(ctx)
  end, self._components)
  return table.concat(strs, "%=")
end

return M
