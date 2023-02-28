local vim = vim

local M = {}

function M.require(name)
  vim.validate({ name = { name, "string" } })

  local Component = require("stlparts.vendor.misclib.module").find("stlparts.component." .. name)
  if not Component then
    return nil, "not found: " .. name
  end

  return Component
end

local List = M.require("list")

function M.get(component)
  local typ = type(component)

  if typ == "function" then
    return component
  end

  if typ == "string" then
    return function(_)
      return component
    end
  end

  if vim.tbl_islist(component) then
    return List(component)
  end

  error("unexpected type: " .. typ)
end

return M
