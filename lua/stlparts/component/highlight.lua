local highlight = function(hl_group)
  return ("%%#%s#"):format(hl_group)
end

--- Highlight component.
--- @param hl_group string: highlight group
--- @param component StlpartsComponent |StlpartsComponent|
--- @return StlpartsFunctionComponent |StlpartsFunctionComponent|
return function(hl_group, component)
  component = require("stlparts.core.component").get(component)
  local highlight_start = highlight(hl_group)
  return function(ctx)
    return highlight_start .. component(ctx:with_highlight(hl_group)) .. highlight(ctx.hl_group)
  end
end
