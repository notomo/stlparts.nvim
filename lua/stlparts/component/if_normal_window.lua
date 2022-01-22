local M = {}
M.__index = M

function M.new(component)
  local tbl = {
    _is_normal_window = function(window_id)
      return vim.api.nvim_win_get_config(window_id).relative == ""
    end,
    _component = require("stlparts.core.component").get(component),
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  if self._is_normal_window(ctx.window_id) then
    return self._component:build(ctx)
  end
  return ""
end

return M
