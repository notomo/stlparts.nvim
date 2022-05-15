local M = {}
M.__index = M

--- Make tab component that can be used in tabline.
--- @param tabpage number: tabpage handle, or 0 for current tabpage
--- @param component function|table: |stlparts.nvim-types-component|
--- @return table: |stlparts.nvim-types-component|
function M.new(tabpage, component)
  local tab_number = vim.api.nvim_tabpage_get_number(tabpage)
  local window_id = vim.api.nvim_tabpage_get_win(tabpage)
  local tbl = {
    _built_tab_number = "%" .. tostring(tab_number) .. "T",
    _component = require("stlparts.core.component").get(component),
    _window_id = window_id,
  }
  return setmetatable(tbl, M)
end

function M.build(self, ctx)
  return self._built_tab_number .. self._component:build(ctx:window(self._window_id)) .. "%T"
end

return M
