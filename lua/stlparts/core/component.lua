local vim = vim

local M = {}

--- @param name string
function M.require(name)
  local f = require("stlparts.vendor.misclib.module").find("stlparts.component." .. name)
  if not f then
    return "not found: " .. name
  end

  return f
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

  if vim.islist(component) then
    return List(component)
  end

  error("unexpected type: " .. typ)
end

return M
