--- Switch by whether mapping has filetype matched with the buffer's filetype.
--- @param make_key fun(ctx:StlpartsContext):string returns key to switch mapping table value. |StlpartsContext|
--- @param mapping table<string,StlpartsFunctionComponent>
--- @param opts StlpartsSwitchOption? |StlpartsSwitchOption|
--- @return StlpartsFunctionComponent |StlpartsFunctionComponent|
return function(make_key, mapping, opts)
  opts = opts or {}

  local component_map = vim.tbl_map(function(c)
    return require("stlparts.core.component").get(c)
  end, mapping)

  local default_key = opts.default_key or "_"
  local default = require("stlparts.core.component").get(component_map[default_key] or "")

  return function(ctx)
    local key = make_key(ctx)
    local specific = component_map[key]
    if specific then
      return specific(ctx)
    end
    return default(ctx)
  end
end

--- @class StlpartsSwitchOption
--- @field defualt_key string? default: "_"
