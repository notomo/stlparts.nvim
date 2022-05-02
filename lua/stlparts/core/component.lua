local M = {}

function M.get(component)
  local typ = type(component)
  if typ == "table" then
    return component
  end
  if typ == "function" then
    return { build = component }
  end
  error("unexpected type: " .. typ)
end

function M.build(ctx, component)
  return M.get(component):build(ctx)
end

function M.require_as_function(name)
  vim.validate({ name = { name, "string" } })

  local Component = require("stlparts.vendor.misclib.module").find("stlparts.component." .. name)
  if not Component then
    return nil, "not found: " .. name
  end

  return Component.new
end

return M
