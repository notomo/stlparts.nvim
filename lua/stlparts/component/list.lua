local M = {}
M.__index = M

--- Listing components.
--- @param components table: list of |stlparts.nvim-types-component|
--- @param opts table|nil: default: {separator = " "}
--- @return table: |stlparts.nvim-types-component|
function M.new(components, opts)
  opts = opts or {}
  local separator = opts.separator or " "
  local tbl = {
    _components = vim.tbl_map(function(c)
      return require("stlparts.core.component").get(c)
    end, components),
    _separator = separator,
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  local strs = vim.tbl_map(function(c)
    return c:build(ctx)
  end, self._components)
  return table.concat(strs, self._separator)
end

return M
