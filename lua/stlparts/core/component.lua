local M = {}

function M.get(component_or_name, ...)
  local typ = type(component_or_name)
  if typ == "table" then
    return component_or_name
  elseif typ == "function" then
    return { build = component_or_name }
  elseif typ ~= "string" then
    error("unexpected type: " .. typ)
  end

  local name = component_or_name
  local Component = M.require(name)
  if not Component then
    local Err = M.require("error")
    return Err.new("not found: " .. name)
  end

  return Component.new(...)
end

function M.build(ctx, component_or_name)
  return M.get(component_or_name):build(ctx)
end

function M.require(name)
  return require("stlparts.lib.module").find("stlparts.component." .. name)
end

return M
