--- Make tab component that can be used in tabline.
--- @param tabpage integer: tabpage handle, or 0 for current tabpage
--- @param component StlpartsComponent |StlpartsComponent|
--- @return StlpartsFunctionComponent |StlpartsFunctionComponent|
return function(tabpage, component)
  component = require("stlparts.core.component").get(component)

  local tab_number = vim.api.nvim_tabpage_get_number(tabpage)
  local built_tab_number = "%" .. tostring(tab_number) .. "T"
  local window_id = vim.api.nvim_tabpage_get_win(tabpage)

  return function(ctx)
    return built_tab_number .. component(ctx:window(window_id)) .. "%T"
  end
end
