local M = {}
M.__index = M

--- Switch by whether mapping has filetype matched with the buffer's filetype.
--- @param make_key fun(ctx:table):string returns key to switch mapping table value
--- @param mapping table: |stlparts.nvim-types-component| table
--- @param opts table|nil: {default_key = "_"}
--- @return table: |stlparts.nvim-types-component|
function M.new(make_key, mapping, opts)
  opts = opts or {}

  local component_map = vim.tbl_map(function(c)
    return require("stlparts.core.component").get(c)
  end, mapping)

  local default_key = opts.default_key or "_"
  local default_component = require("stlparts.core.component").get(component_map[default_key] or "")

  local tbl = {
    _make_key = make_key,
    _component_map = component_map,
    _default = default_component,
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  local key = self._make_key(ctx)
  local specific = self._component_map[key]
  if specific then
    return specific:build(ctx)
  end
  return self._default:build(ctx)
end

return M
