local vim = vim

local M = {}

function M.require_as_function(name)
  vim.validate({ name = { name, "string" } })

  local Component = require("stlparts.vendor.misclib.module").find("stlparts.component." .. name)
  if not Component then
    return nil, "not found: " .. name
  end

  return Component.new
end

local List = M.require_as_function("list")

function M.get(component)
  if vim.tbl_islist(component) then
    return List(component)
  end

  local typ = type(component)

  if typ == "table" then
    return component
  end

  if typ == "function" then
    return {
      build = function(_, ctx)
        return component(ctx)
      end,
    }
  end

  if typ == "string" then
    return {
      build = function(_)
        return component
      end,
    }
  end

  error("unexpected type: " .. typ)
end

function M.build(ctx, component)
  return M.get(component):build(ctx)
end

return M
