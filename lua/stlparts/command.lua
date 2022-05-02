local ReturnValue = require("stlparts.vendor.misclib.error_handler").for_return_value()

function ReturnValue.build(window_id)
  local ctx = require("stlparts.core.context").new(window_id)
  local component = require("stlparts.core.setting").state().root
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

function ShowError.set_root(component)
  return require("stlparts.core.setting").set({ root = component })
end

return vim.tbl_extend("force", ReturnValue:methods(), ShowError:methods())
