local ReturnValue = require("stlparts.vendor.misclib.error_handler").for_return_value()

function ReturnValue.build(name, opts)
  opts = opts or {}
  local ctx = require("stlparts.core.context").new(opts.window_id, opts.hl_group)
  local component = require("stlparts.core.setting").state()[name]
  return require("stlparts.core.component").build(ctx, component)
end

function ReturnValue.component(name)
  local f, err = require("stlparts.core.component").require_as_function(name)
  if err then
    return nil, err
  end
  return f
end

local ShowError = require("stlparts.vendor.misclib.error_handler").for_show_error()

function ShowError.set(name, component)
  return require("stlparts.core.setting").set({ [name] = component })
end

return vim.tbl_extend("force", ReturnValue:methods(), ShowError:methods())
