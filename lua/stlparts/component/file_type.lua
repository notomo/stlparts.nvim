local M = {}
M.__index = M

function M.new(mapping, default)
  local tbl = {
    _mapping = vim.tbl_map(function(component_or_name)
      return require("stlparts.core.component").get(component_or_name)
    end, mapping),
    _default = require("stlparts.core.component").get(default),
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  local bufnr = vim.api.nvim_win_get_buf(ctx.window_id)
  local filetype = vim.bo[bufnr].filetype
  local specific = self._mapping[filetype]
  if specific then
    return specific:build(ctx)
  end
  return self._default:build(ctx)
end

return M
