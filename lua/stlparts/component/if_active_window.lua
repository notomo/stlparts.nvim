local M = {}
M.__index = M

function M.new(active, inactive)
  local tbl = {
    _is_active = function(window_id)
      return window_id == vim.api.nvim_get_current_win()
    end,
    _active = require("stlparts.core.component").get(active),
    _inactive = require("stlparts.core.component").get(inactive),
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  if self._is_active(ctx.window_id) then
    return self._active:build(ctx)
  end
  return self._inactive:build(ctx)
end

return M
