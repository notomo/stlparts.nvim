local messagelib = require("stlparts.lib.message")

local M = {}

local ErrorHandler = {}
ErrorHandler.__index = ErrorHandler
M.ErrorHandler = ErrorHandler

function ErrorHandler.new(f)
  local tbl = { _return = f }
  return setmetatable(tbl, ErrorHandler)
end

function ErrorHandler.for_return_value()
  return ErrorHandler.new(function(f)
    local ok, result, err = xpcall(f, debug.traceback)
    if not ok then
      messagelib.error(result)
      return nil
    elseif err then
      messagelib.warn(err)
      return err
    end
    return result
  end)
end

function ErrorHandler.for_return_err()
  return ErrorHandler.new(function(f)
    local ok, err = xpcall(f, debug.traceback)
    if not ok then
      messagelib.error(err)
      return nil
    elseif err then
      messagelib.warn(err)
      return err
    end
    return nil
  end)
end

function ErrorHandler.methods(self)
  local methods = {}
  for key in pairs(self) do
    methods[key] = function(...)
      return self(key, ...)
    end
  end
  return methods
end

function ErrorHandler.__call(self, key, ...)
  local args = vim.F.pack_len(...)
  local f = function()
    return self[key](vim.F.unpack_len(args))
  end
  return self._return(f)
end

return M
