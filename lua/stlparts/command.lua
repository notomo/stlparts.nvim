local ReturnValue = require("stlparts.lib.error_handler").ErrorHandler.for_return_value()

function ReturnValue.build(window_id)
  local ctx = require("stlparts.core.context").new(window_id)
  local component = require("stlparts.core.setting").state().root
  return require("stlparts.core.component").build(ctx, component)
end

function ReturnValue.component(name)
  vim.validate({ name = { name, "string" } })
  local Component = require("stlparts.core.component").require(name)
  if not Component then
    return nil, "not found: " .. name
  end
  return Component.new
end

local ReturnErr = require("stlparts.lib.error_handler").ErrorHandler.for_return_err()

function ReturnErr.set_root(component)
  return require("stlparts.core.setting").set({ root = component })
end

return vim.tbl_extend("force", ReturnValue:methods(), ReturnErr:methods())
