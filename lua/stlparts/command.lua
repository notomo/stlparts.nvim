local M = {}

function M.build(name, opts)
  opts = opts or {}
  local component = require("stlparts.core.setting").state()[name]
  local ctx = require("stlparts.core.context").new(opts.window_id, opts.hl_group)
  return component(ctx)
end

function M.component(name)
  local f, err = require("stlparts.core.component").require(name)
  if err then
    error("[stlparts] " .. err, 0)
  end
  return f
end

function M.set(name, component)
  component = require("stlparts.core.component").get(component)
  return require("stlparts.core.setting").set({ [name] = component })
end

return M
