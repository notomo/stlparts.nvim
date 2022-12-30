local M = {}

function M.build(name, opts)
  opts = opts or {}
  local ctx = require("stlparts.core.context").new(opts.window_id, opts.hl_group)
  local component = require("stlparts.core.setting").state()[name]
  return require("stlparts.core.component").build(ctx, component)
end

function M.component(name)
  local f, err = require("stlparts.core.component").require_as_function(name)
  if err then
    return nil, err
  end
  return f
end

function M.set(name, component)
  return require("stlparts.core.setting").set({ [name] = component })
end

return M
